function love.load(args)
	width=args[1] or love.graphics.getWidth()
	height=args[2] or love.graphics.getHeight()
	particles={}
	AddParticle(10,10,20,{0,1,1},20,20)
end

function love.update(dt)
	for i,particle in ipairs(particles) do
		particle.x=particle.x+particle.dx*dt
		particle.y=particle.y+particle.dy*dt
		particle.dx=particle.dx+particle.dx*dt
		particle.dy=particle.dy+particle.dy*dt
		particle.x=Clamp(particle.x,1,width)
		particle.y=Clamp(particle.y,1,height)
	end
end

function love.draw()
	for i,particle in ipairs(particles) do
		love.graphics.setColor(particle.color)
		love.graphics.circle("fill",particle.x,particle.y,particle.size)
	end
end

function AddParticle(x,y,size,color,dx,dy)
	particles[#particles+1]={x=x,y=y,size=size,color=color,dx=dx,dy=dy}
end

function Clamp(value,min,max)
	return math.max(math.min(value,max),min)
end