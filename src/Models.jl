module Models

import Base: start, next, done, length
import Base: getindex, show

export
  AbstractModel,
  AbstractLinearModel,
  AbstractModelArray,
  Model,
  ModelArray,

  model,
  update!,
  stateof,
  sys_f,
  sys_∇x_f,
  sys_g,
  sys_∇x_g,
  sys_N

include("coliterator.jl")
include("models.jl")
include("model_array.jl")
include("linear_model.jl")

end
