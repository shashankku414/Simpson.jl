using Test
using QuadGK
using Trapz

include("../src/Simpson.jl")


x = collect(range(0, 9, length=101))
y = map(t -> (cos(t))^2, x)
int_exact = 4.3123

quad_int = quadgk(t -> (cos(t))^2, 0, 9, rtol=1e-6)[1]

@test round(Simpson.simpson(y, x), digits=4) ≈ int_exact
@test isapprox(Simpson.simpson(y, x), quad_int, rtol=1e-4)