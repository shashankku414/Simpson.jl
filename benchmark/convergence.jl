using BenchmarkTools
using Trapz
using Plots
using QuadGK

include("../src/Simpson38.jl")

function main()
    grid_size = 12:1:101
    simp_error = zeros(Float64, length(grid_size))
    trap_error = zeros(Float64, length(grid_size))
    simp_time = zeros(Float64, length(grid_size))
    trap_time = zeros(Float64, length(grid_size))

    int_act = quadgk(t -> (cos(t))^2, 0, 9, rtol=1e-6)[1]
    for i in eachindex(grid_size)
        x = collect(range(0, 9, length=grid_size[i]))
        y = map(t -> (cos(t))^2, x)
        # println(integral(y, x))
        simp_out = Simpson38.simpson38(y, x)
        trap_out = trapz(x, y)
        simp_error[i] = abs(simp_out - int_act)/(int_act) * 100
        trap_error[i] = abs(trap_out - int_act)/(int_act) * 100
        simp_time[i] = @elapsed Simpson38.simpson38(y, x)
        trap_time[i] = @elapsed trapz(x, y)
    end

    plot(grid_size, trap_error, xlabel = "Grid size", ylabel="% error", label="Trapezoidal Method")
    plot!(grid_size, simp_error, xlabel = "Grid size", ylabel="% error", label="Simpson Method")
    savefig("err.png")

    plot(grid_size, trap_time, xlabel = "Grid size", ylabel="Time elapsed (s)", label="Trapezoidal Method")
    plot!(grid_size, simp_time, xlabel = "Grid size", ylabel="Time elapsed (s)", label="Simpson Method")
    savefig("time.png")
end

main()