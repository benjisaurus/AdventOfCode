package main

import (
	"fmt"
)

func contains(s []int, i int) bool {
	for _, item := range s {
		if item == i {
			return true
		}
	}
	return false
}

func contains2(s [][]int, a []int) bool {
	for _, i := range s {
		if i[0] == a[0] && i[1] == a[1] {
			return true
		}
	}
	return false
}

func getXs(min int, max int) []int {
	var xs []int
VelLoop:
	for vel := 1; vel < min; vel++ {
		currentVel := vel
		for x := currentVel; x <= max; x += currentVel {
			if x > min {
				if contains(xs, vel) {
					continue VelLoop
				} else {
					xs = append(xs, vel)
				}
			}
			if currentVel == 0 {
				continue VelLoop
			}
			currentVel--
		}
	}

	return xs
}

func getYs(xs []int, minX int, maxX int, minY int, maxY int) []int {
	var ys []int
	highestY := 0
	highestX := 0
	highest := 0

	for _, x := range xs {
		for y := 1; y < maxX; y++ {
			velX := x
			velY := y
			currentX := 0
			currentY := 0
			currentHighest := 0
			for step := 0; currentX <= maxX && currentY >= minY; step++ {
				currentX += velX
				currentY += velY
				if currentY > currentHighest {
					currentHighest = currentY
				}
				if currentX >= minX && currentX <= maxX &&
					currentY >= minY && currentY <= maxY &&
					currentHighest > highest {
					highest = currentHighest
					highestX = x
					highestY = y
				}
				if velX > 0 {
					velX -= 1
				}
				velY -= 1
			}
		}
	}

	ys = append(ys, highestX)
	ys = append(ys, highestY)
	ys = append(ys, highest)
	return ys
}

func part2(minX int, maxX int, minY int, maxY int) [][]int {
	var velocities [][]int
	for x := 0; x <= maxX; x++ {
		for y := minY; y < maxX; y++ {
			//fmt.Println(x, ", ", y)
			velX := x
			velY := y
			currentX := 0
			currentY := 0
			for step := 0; currentX <= maxX && currentY >= minY; step++ {
				currentX += velX
				currentY += velY
				if currentX >= minX && currentX <= maxX &&
					currentY >= minY && currentY <= maxY {
					newV := []int{x, y}
					if !contains2(velocities, newV) {
						velocities = append(velocities, newV)
						//fmt.Println(x, ", ", y)
					}
				}

				if velX > 0 {
					velX -= 1
				}
				velY -= 1
			}
		}
	}

	return velocities
}

func main() {
	//xs := getXs(20, 30)
	//xs := getXs(150, 171)
	//fmt.Println(xs)
	//ys := getYs(xs, 20, 30, -10, -5)
	//ys := getYs(xs, 150, 171, -129, -70)
	//fmt.Println(ys)
	//p2 := part2(20, 30, -10, -5)
	p2 := part2(150, 171, -129, -70)
	//fmt.Println(p2)
	// for _, p := range p2 {
	// 	fmt.Printf("%d, %d\n", p[0], p[1])
	// }
	fmt.Println(len(p2))
}
