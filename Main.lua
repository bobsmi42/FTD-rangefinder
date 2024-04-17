-- Define a function to solve a system of linear equations
function solveLinearEquations(coefficients, constants)
    local matrixA = coefficients
    local matrixB = {constants}

    -- Concatenate the matrices to solve the system
    for i = 1, #matrixA do
        table.insert(matrixA[i], matrixB[1][i])
    end

    -- Perform Gaussian elimination
    for i = 1, #matrixA do
        local pivot = matrixA[i][i]
        for j = i + 1, #matrixA do
            local factor = matrixA[j][i] / pivot
            for k = i, #matrixA[i] do
                matrixA[j][k] = matrixA[j][k] - factor * matrixA[i][k]
            end
        end
    end

    -- Back-substitution
    local solution = {}
    for i = #matrixA, 1, -1 do
        local sum = matrixA[i][#matrixA[i]]
        for j = i + 1, #matrixA[i] - 1 do
            sum = sum - matrixA[i][j] * (solution[j] or 0)
        end
        solution[i] = sum / matrixA[i][i]
    end

    return solution
end

-- Example system of linear equations: 2x + 3y = 8, 4x - 5y = -7
local coefficients = {{2, 3}, {4, 5}}
local constants = {8, 7}

-- Solve the system
local result = solveLinearEquations(coefficients, constants)

-- Print the solution
for i, value in ipairs(result) do
    print("x" .. i .. " =", value)
end

