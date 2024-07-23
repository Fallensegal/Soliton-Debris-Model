import re

from prompt_toolkit.validation import Validator


def validate_email(email: str) -> bool:
    email_pattern: str = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
    compiled_pattern = re.compile(email_pattern)
    return compiled_pattern.match(email)


def validate_bool(prompt_input: str) -> bool:
    bool_patterns: str = [
        r"\b([Tt]rue|[Ff]alse)\b",
        r"\b[tTfF]\b",
        r"\b([Yy]es|[Nn]o)\b",
        r"\b([yYnN])\b",
    ]
    compiled_patterns = [re.compile(pattern) for pattern in bool_patterns]
    return any(pattern.match(prompt_input) for pattern in compiled_patterns)


email_validator = Validator.from_callable(
    validate_email,
    error_message="E-mail entered does not have valid format...",
    move_cursor_to_end=True,
)

boolean_validator = Validator.from_callable(
    validate_bool,
    error_message="Inappropriate Input, Please Provide Valid Input... ",
    move_cursor_to_end=True,
)
