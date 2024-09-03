module Simpson38

export simpson38

@inline function simpson38(y::AbstractArray, x::AbstractArray)
    n = length(x)

    if (n-1) % 3 == 0
        h = (x[end] - x[1]) / (n - 1)
        simp_sum = y[1] + y[end]

        @inbounds for i in 2:n-1
            i%3==1 ? simp_sum += 2*y[i] : simp_sum += 3*y[i]
        end
        
        return 3*h/8 * simp_sum
    
    elseif (n-1) % 3 == 1
        h = (x[end-1] - x[1]) / (n - 2)
        simp_sum = y[1] + y[end-1]

        @inbounds for i in 2:n-2
            i%3==1 ? simp_sum += 2*y[i] : simp_sum += 3*y[i]
        end
        trap_last = (x[end] - x[end-1]) * (y[end] + y[end-1]) / 2
        
        return 3*h/8 * simp_sum + trap_last
    
    else
        h = (x[end-2] - x[1]) / (n - 3)
        simp_sum = y[1] + y[end-2]

        @inbounds for i in 2:n-3
            i%3==1 ? simp_sum += 2*y[i] : simp_sum += 3*y[i]
        end
        simp13_last = (x[end] - x[end-2])/6 * (y[end] + 4*y[end-1] + y[end-2])
        
        return 3*h/8 * simp_sum + simp13_last
    end
end

end # module Simpson
