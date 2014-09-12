abstract AbstractModelArray <: AbstractModel

type ModelArray{T <: AbstractModel, S <: String} <: AbstractModelArray
    models::Array{T,1}
    names::Array{S,1}
end

ModelArray{T <: AbstractModel}(models::Array{T,1}) = ModelArray(models, [ "model$(i)" for i in 1:length(models) ])

function update!{T}(models::ModelArray{T})
    for model in models
        model.x = sys_f(model)(model.x)
    end
end

function update!{T,S}(models::ModelArray{T}, u::Matrix{S})
    for (model,u) in zip(models, coliterator(u))
        any(isnan(u)) ? model.x = sys_f(model)(model.x) : model.x = sys_f(model)(model.x, u)
    end
end

function stateof{T <: AbstractModelArray}(ma::T)
    vcat([ m.x for m in ma.models ]...)
end

length{T <: AbstractModel, S <: String}(ma::ModelArray{T,S}) = length(ma.models)
start{T <: AbstractModel, S <: String}(ma::ModelArray{T,S}) = 1
next{T <: AbstractModel, S <: String}(ma::ModelArray{T,S}, i) = (ma.models[i], i+1)
done{T <: AbstractModel, S <: String}(ma::ModelArray{T,S}, i) = (length(ma.models)+1 <= i)

function getindex{T <: AbstractModelArray}(ma::T, n::Integer)
    ma.models[n]
end 

function show{T <: AbstractModel, S <: String}(io::IO, ma::ModelArray{T,S})
    print(io, join( [ "$(m[1]): $(m[2].x')" for m in zip(ma.names, ma.models) ], '\n'))
end
