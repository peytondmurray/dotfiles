import os
import sys
import argparse
import pathlib
import tomllib
import re
import pprint
import textwrap
from collections import defaultdict


def load_config(path):

    with open(path, 'rb') as f:
        raw_config = tomllib.load(f)

    configs = defaultdict(dict)

    for platform in raw_config['platforms']:
        for template, target in raw_config['templates'].items():
            configs[platform][template.format(platform)] = target

    return dict(configs)


def load_ignore(path):
    """Load the list of ignored items.

    Parameters
    ----------
    path : pathlib.Path or str
        Path to the ignore list
    """
    with open(path, 'r') as f:
        lines = f.readlines()

    return [pathlib.Path(line.rstrip()) for line in lines if re.match(r'[^#]\S+', line)]


def get_args():
    """Get the command line arguments.

    Returns
    -------
    argparse.ArgumentParser
        Arguments specified on the command line.
    """

    parser = argparse.ArgumentParser(description='Load dotfile symlinks.')
    parser.add_argument(
        '-c',
        '--config',
        help="Specify a config name given in ./syconfig.yaml",
    )
    parser.add_argument(
        '-d', '--dry', help="Dry run: don't write any symlinks.", action='store_true'
    )
    parser.add_argument('-l', '--list', help="List available configs.", action='store_true')
    parser.add_argument(
        '-a', '--ask', help="Ask before overwriting.", action='store_true', default=False
    )

    if len(sys.argv) == 1:
        parser.print_help()
        sys.exit()

    return parser.parse_args()


def filter_items(items, ignore):
    """Return a list of files to be symlinked to.

    Directories are ignored.

    Parameters
    ----------
    items : list of pathlib.Path
        Unfiltered recursive list of directory contents.
    ignore :
        List of directories/files to ignore.

    Returns
    -------
    list of pathlib.Path
        List of files to be symlinked to
    """
    ignore_dirs = [path for path in ignore if path.is_dir()]
    ignore_globs = []
    for ignore_dir in ignore_dirs:
        ignore_globs.extend(ignore_dir.glob('**/*'))

    ignore.extend(ignore_globs)

    filtered = []
    for item in items:
        if item in ignore:
            ignore.remove(item)
            continue

        if item.is_file():
            filtered.append(item)

    return filtered


def symlink(items, dry=False, prompt=False, config_paths=None):
    """Generate the symlinks for the specified items.

    Parameters
    ----------
    items : list of pathlib.Path
        List of paths to symlink to
    dry : bool
        If True, don't write any symlinks; only print where they would be written.
    prompt : bool
        If True, prompt before overwriting existing paths.
    """
    if config_paths is None:
        config_paths = {}
    home = pathlib.Path.home()
    cwd = pathlib.Path.cwd()

    for item in items:
        if str(item) in config_paths:
            link = home / config_paths[str(item)]
        else:
            link = home / item

        target = cwd / item
        print(f'\t{link} -> {target}')

        if not dry:
            if not link.parents[0].exists():
                link.parents[0].mkdir(parents=True)

            if link.exists() or link.is_symlink():
                if prompt:
                    # Ask before overwriting
                    response = None
                    while response not in ['y', 'n', '']:
                        response = input(f'{link} exists. Replace? [Y/n]: ').lower()

                    # If the user doesn't want to replace the link, move on to the next one
                    if response == 'n':
                        continue

                link.unlink()
                if link.exists():
                    os.remove(str(link))

            try:
                link.symlink_to(target)
            except FileNotFoundError:
                print(f"{link} doesn't exist; skipping.")

    return


def print_configs(config_file, config):
    """Print the current config file and the associated config dict.

    Parameters
    ----------
    config_file : str
        Config file path
    config : dict
        Configuration dictionary read from the contents at config_file
    """
    print(f"Configs available from {config_file}:")
    print(textwrap.indent(pprint.pformat(config), prefix='\t'))
    return


def main():

    config_file = './syconfig.toml'
    arguments = get_args()

    config = load_config(config_file)

    if arguments.list:
        print_configs(config_file, config)
        return

    if arguments.config not in config:
        print(f'Invalid config specified: {arguments.config}')
        print_configs(config_file, config)
        return

    ignore = load_ignore('./.syignore')
    items = filter_items(pathlib.Path('./').glob('**/*'), ignore)

    symlink(items, arguments.dry, arguments.ask, config_paths=config[arguments.config])
    print("Done!")

    return


if __name__ == "__main__":
    main()
