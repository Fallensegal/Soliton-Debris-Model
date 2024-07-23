import re

# Regex Comparison Strings

REGEX_BOOL_TRUE = re.compile(r"\b([Tt]rue|[tT]|[yY]es|[yY])\b")
REGEX_BOOL_FALSE = re.compile(r"\b([fF]alse|[fF]|[nN]o|[nN])\b")
