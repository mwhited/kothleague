def snake(low, high, x)
    k = (high-low+1)
    m = x % (2*k)
    v = m + low - k - 0.5
    a = v.abs()
    f = a.floor()
    r = k - f
    puts low.to_s + ", " + high.to_s + ", " + x.to_s + ", " + k.to_s + ", " + m.to_s + ", " + v.to_s + ", " + a.to_s + ", " + f.to_s + ", " + r.to_s
    return r
end

snake(1,4,0)
snake(1,4,1)
snake(1,4,2)
snake(1,4,3)
snake(1,4,4)
snake(1,4,5)
snake(1,4,6)
snake(1,4,7)
snake(1,4,8)
snake(1,4,9)
snake(1,4,10)
snake(1,4,11)
snake(1,4,12)
snake(1,4,13)
snake(1,4,14)
snake(1,4,15)
snake(1,4,16)
snake(1,4,17)
snake(1,4,18)
snake(1,4,19)
snake(1,4,20)
