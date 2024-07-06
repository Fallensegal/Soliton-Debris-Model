from isr_debris_sim.features.madrigal.service import TestMadrigal
from isr_debris_sim.features.spacetrack.service import TestSpaceTrack


def test_function() -> None:
    test_one = TestMadrigal(test="build")
    test_two = TestSpaceTrack(test="test")

    print(f"{test_one.test}, {test_two.test}")
