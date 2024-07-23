import click
from PyInquirer import prompt

from isr_debris_sim.core.prompts.init import init_questions
from isr_debris_sim.shared.style import init_style


@click.command()
def init() -> None:
    init_answers = prompt.prompt(init_questions, style=init_style)
