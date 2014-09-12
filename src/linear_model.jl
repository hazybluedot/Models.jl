abstract AbstractLinearModel <: AbstractModel

sys_f{T <: AbstractLinearModel}(lm::T) = x -> sys_A(lm) * x
sys_∇x_f{T <: AbstractLinearModel}(lm::T) = x -> sys_A(lm)
