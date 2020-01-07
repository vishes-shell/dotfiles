from setuptools import setup

setup(
    name="gh",
    version="0.1",
    description="Simple script to view sources of locally cloned github repos",
    py_modules=["gh"],
    install_requires=["Click"],
    entry_points="""
        [console_scripts]
        gh=gh:cli
    """,
)
