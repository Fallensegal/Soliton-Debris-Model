from isr_debris_sim.features.madrigal.service import TestMadrigal
from isr_debris_sim.features.spacetrack.service import TestSpaceTrack


def test_function() -> None:
    testOne = TestMadrigal(test="build")
    testTwo = TestSpaceTrack(test="test")

    print(f"{testOne.test}, {testTwo.test}")
