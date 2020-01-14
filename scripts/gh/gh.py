import os

import click


def get_projects(ctx, args, incomplete):
    print(incomplete)
    return [d for d in os.listdir(os.path.expanduser("~/github/")) if incomplete in d]


@click.command()
@click.argument("project", type=click.STRING, autocompletion=get_projects)
def cli(project):
    os.system(f"kitty @ set-tab-title {project}")
    initial_dir = os.getcwd()
    project_dir = f"~/github/{project}"
    os.chdir(os.path.expanduser(project_dir))
    click.edit(filename="./")
    # roll back to initial dir
    os.chdir(initial_dir)
    os.system("kitty @ set-tab-title use me")
