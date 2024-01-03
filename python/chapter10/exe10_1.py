from math import radians, sin, cos


def main():
    angle = float(input("Enter the launch angle (in degrees): "))
    vel = float(input("Enter the initial velocity (in meters/sec): "))
    h0 = float(input("Enter the initial height (in meters): "))
    time = float(input("Enter the time interval between position calculations: "))
    theta = radians(angle)
    xpos = 0
    ypos = h0
    xvel = vel * cos(theta)
    yvel = vel * sin(theta)
    maxh = float("-inf")
    while ypos >= 0.0:
        xpos = xpos + time * xvel
        yvel1 = yvel - time * 9.8
        ypos = ypos + time * (yvel + yvel1) / 2.0
        yvel = yvel1
        if maxh < ypos:
            maxh = ypos
    print("\nDistance traveled:{0: 0.1f} meters.".format(xpos))
    print("Maximum height:{0: 0.1f}".format(maxh))


main()
