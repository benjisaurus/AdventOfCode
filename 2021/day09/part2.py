def get_input(filename):
    content = []
    for line in open(filename, 'r').readlines():
        nums = []
        line_str = line.strip()
        for ch in line_str:
            nums.append(int(ch))
        content.append(nums)
    return content

def get_dim(grid):
    rows = len(grid)
    cols = len(grid[0])
    return (rows, cols)

def get_neighbors(x,y,x_max,y_max):
    neighbors = []
    for new_x in range(x - 1, x + 2):
        for new_y in range(y - 1, y + 2):
            if new_x >=0 and new_y >= 0 and new_x < x_max and new_y < y_max:
                neighbors.append((new_x,new_y))
    return neighbors