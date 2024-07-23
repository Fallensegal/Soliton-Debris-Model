from typing import Any

from prompt_toolkit import PromptSession
from prompt_toolkit.filters import Condition
from prompt_toolkit.key_binding import KeyBindings

from isr_debris_sim.shared.prompts.validators import email_validator


def prompt_spacetrack_auth_information() -> dict[str, str]:
    spacetrack_prompt_session: PromptSession = PromptSession()
    password_binding = KeyBindings()
    hidden: list[bool] = [True]

    @password_binding.add("c-t")
    def _(event: Any) -> None:  # noqa: ARG001
        """Keyboard binding for controlling visibility of password."""
        hidden[0] = not hidden[0]

    email = spacetrack_prompt_session.prompt(
        "Enter SpaceTrack E-Mail Address: ",
        validator=email_validator,
        validate_while_typing=False,
    )
    password = spacetrack_prompt_session.prompt(
        "Enter SpaceTrack Password: ",
        is_password=Condition(lambda: hidden[0]),
        key_bindings=password_binding,
    )

    return {"ST_EMAIL": email, "ST_PASSWORD": password}
