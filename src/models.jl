abstract AbstractModel

type Model{T} <: AbstractModel
    x::T
    dt::Float64
end

function model{T}(f::Function, ic::T)
    Model{T}(f, ic)
end

function update!{T <: AbstractModel}(model::T)
    model.x = sys_f(model)(model.x)
end

function update!{T <: AbstractModel,S}(model::T, u::Vector{S})
    model.x = sys_f(model)(model.x, u)
end

function run{T}(model::Model{T}, interval::Range1)
    println(model.x)
    for i in interval
        update!(model)
        println(model.x)
    end
end

function stateof{T <: AbstractModel}(m::T)
    return m.x
end

for ext =(:sys_f, :sys_g, :sys_∇x_f, :sys_∇x_g)
    @eval ($ext){T <: AbstractModel}(m::T) = error("$(typeof(m)): no implementation of '$(ext)(m::$(typeof(m)))'")
end

function sys_N{T <: AbstractModel}(m::T)
    m.N
end
