import click

@click.group()
def app() -> None:
    pass

app.add_command(init)

if __name__ == "__main__":
    app()
