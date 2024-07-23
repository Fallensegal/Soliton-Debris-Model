from prompt_toolkit import PromptSession

from isr_debris_sim.shared.enums.prompts import REGEX_BOOL_TRUE
from isr_debris_sim.shared.prompts.validators import boolean_validator


def prompt_init_workflow_confirmation() -> bool:
    init_prompt_session: PromptSession = PromptSession()

    init_workflow_prompt = init_prompt_session.prompt(
        "Execute Init Workflow? (y/n): ",
        validator=boolean_validator,
        validate_while_typing=False,
    )

    return REGEX_BOOL_TRUE.match(init_workflow_prompt)
