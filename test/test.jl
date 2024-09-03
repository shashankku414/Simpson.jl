using Test
using QuadGK
using Trapz

include("../src/Simpson38.jl")


x = collect(range(0, 9, length=102))
y = map(t -> (cos(t))^2, x)
int_exact = 4.31225

quad_int = quadgk(t -> (cos(t))^2, 0, 9, rtol=1e-6)[1]

@test round(Simpson38.simpson38(y, x), digits=5) ≈ int_exact
@test isapprox(Simpson38.simpson38(y, x), quad_int, rtol=1e-4)