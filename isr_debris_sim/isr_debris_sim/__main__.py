import click

from isr_debris_sim.cli import init


@click.group()
def app() -> None:
    pass


app.add_command(init)

if __name__ == "__main__":
    app()
