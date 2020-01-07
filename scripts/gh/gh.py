import os

import click


@click.command()
@click.argument("project", type=click.STRING)
def cli(project):
    os.system(f"kitty @ set-tab-title {project}")
    initial_dir = os.getcwd()
    project_dir = f"~/github/{project}"
    os.chdir(project_dir)
    click.edit(filename="./")
    # roll back to initial dir
    os.chdir(initial_dir)
    os.system("kitty @ set-tab-title use me")

