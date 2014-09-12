import Base: start, next, done

type coliterator{T}
    m::Matrix{T}
end

start(it::coliterator) = 1
next(it::coliterator, i::Integer) = (it.m[:,i], i+1)
done(it::coliterator, i::Integer) = size(it.m,2)+1 <= i
