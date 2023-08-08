
function direct_pi(Ntrials::Int; seed::Int = 1000)
    Random.seed!(seed)
    Nhits = zero(Ntrials)
    for _ in 1:Ntrials
        x,y = rand(2,1)
        if x^2 + y^2 < 1.0
            Nhits += 1
        end
    end
    return 4.0 * Nhits / Ntrials
end

function markov_pi(Ntrials::Int, δ::Float64; seed::Int = 1000)
    x,y = 1.0, 1.0
    Nhits = zero(Ntrials)
    for _ in 1:Ntrials
        Δx,Δy = δ .* (2.0 .* rand(2,1) .- 1.0)
        if abs(x + Δx) < 1.0 && abs(y + Δy) < 1.0
            x += Δx
            y += Δy
        end
        if x^2 + y^2 < 1.0
            Nhits += 1
        end
    end
    return 4.0 * Nhits / Ntrials
end
