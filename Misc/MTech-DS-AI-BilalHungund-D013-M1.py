# Import the library
import copy

# Pacman and Food Position
input_x, input_y = 5, 5
food_x, food_y = 2, 3

# Enivronment for Pacman and possible hurdles and paths
n = 7
environment = [['%', '-', '-', '%', '-', '-', '%', '-'], 
               ['-', '-', '%', '%', '%', '-', '%', '-'], 
               ['%', '-', '-', '.', '-', '-', '%', '-'], 
               ['-', '%', '-', '-', '%', '-', '-', '%'], 
               ['-', '-', '-', '-', '-', '-', '-', '-'], 
               ['%', '-', '-', '%', '-', 'P', '%', '-'],
               ['%', '-', '-', '-', '%', '-', '-', '-']]

# Possible routes or paths
routes = []
final_paths = []

# Initialize Manhattan Distance
d = 0

# Data Structure used: Queue
# Queue contains starting location of Pacman, null route, and manhattan distance
queue = []
queue.append([input_x, input_y, routes])

# Directions of Pacman to move from one cell to another
# Possible directions Up, Down, Left and Right

up, left, down, right  = [-1 ,0], [0, -1], [0, 1], [1, 0]
directions = [up, left, down, right]

# Function to compute the Manhattan Heuristic Distance between food position and next position
def compute_manhattan_heuristic(d, nx, ny):
    return (d + abs(food_x - nx) + abs(food_y - ny))

# Function to check whether Pacman can move in any next directions which was computed
def is_valid_move(nx, ny):
    if environment[nx][ny] == '-' or environment[nx][ny] == '.':
        # If no obstacle then marked all new direction as Pacman Visiting Cell(s)
        environment[nx][ny] = '='
        return True
    return False

# Function to check whether Pcaman found the food or not
def is_pacman_found_food(x, y):
    if x == food_x and y == food_y:
        return True
    return False

# Function to check whether Pacman is in the environment or not
def is_pacman_in_environment(nx, ny):
    if nx < 0 or nx >= n or ny < 0 or ny >= n:
        return True
    return False

# Function to print the enivronment
def show_environment():
    for i in range(n):
        for j in range(n+1): 
            print(environment[i][j], end=' ')
        print('')

# Function to simulate the Pacman
def simulation():
    
    # List for shortest path
    shortest_path = []
    
    # Print all the inputs and environment
    print('PacMan Location:', (input_x, input_y))
    print('Food Location:', (food_x, food_y))
    print('\nInput Environment for the Pacman')
    show_environment()
    
    # Iterate the loop until Pacman finds the food
    while len(queue) != 0:
        
        # Dequeue the queue
        X, Y, r = queue.pop(0)
        
        # Append the X and Y in the routes given by queue
        routes = copy.deepcopy(r)
        routes.append([X, Y])
        
        # Check whether Pacman found the food location or not
        if is_pacman_found_food(X, Y):
            # Return the shortest path if food location found
            shortest_path = copy.deepcopy(r)
            break
        
        # Compute all the four possible moves (directions) for pacman in any cell
        # Four Directions, left, right, up, down
        next_all_moves = []
        for direction in directions:
            # Calculating each direction cell number
            next_x, next_y = X + direction[0], Y + direction[1]
            
            # Check whether the Pacman is in the environment or not
            if is_pacman_in_environment(next_x, next_y):
                continue
            
            # Check whether the next cell is not wall and it is a path for the Pacman
            if is_valid_move(next_x, next_y):
                # If it is a path then compute the Manhattan Heuristic Distance for the next cell
                # Append the results in the list
                next_all_moves.append([next_x, next_y, compute_manhattan_heuristic(d, next_x, next_y)])
        
        # Sort all the sublists with the Manhattan Distance as a factor
        next_all_moves.sort(key = lambda x: x[2])
        
        # Append all the next directions or moves with routes in the queue
        for move in next_all_moves:
            queue.append([move[0], move[1], routes])
            
    # Return the shortest paths Pacman Visited and found the food after loop terminated
    return shortest_path

# Run the Simulation
final_paths = simulation()
print('\nNumber of cells Pacman Visited: '+str(len(final_paths)-1))

# Iterate the Shortest Paths
i = 0
print('\nShortest Path: ')
for path in final_paths:
    if i == len(final_paths)-1:
        print(path)
    else:
        print(path, end='->')
    i = i + 1


'''
PacMan Location: (5, 5)
Food Location: (2, 3)

Input Environment for the Pacman
% - - % - - % - 
- - % % % - % - 
% - - . - - % - 
- % - - % - - % 
- - - - - - - - 
% - - % - P % - 
% - - - % - - - 

Number of cells Pacman Visited: 4

Shortest Path: 
[5, 5]->[4, 5]->[3, 5]->[2, 5]->[2, 4]
'''