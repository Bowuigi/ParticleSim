function love.load(args)
	math.randomseed(os.clock()^5)
	width=args[1] or love.graphics.getWidth()
	height=args[2] or love.graphics.getHeight()
	particles={}
	prevparticle={x=0,y=0}
	AddParticle(100,100,20,{0,1,1},30,30)
end

function love.update(dt)
	for i,particle in ipairs(particles) do
		particle.x=particle.x+particle.dx*dt
		particle.y=particle.y+particle.dy*dt
		particle.x=Clamp(particle.x,1,width)
		particle.y=Clamp(particle.y,1,height)
		for j,p in ipairs(particles) do
			local dist = (particle.x-p.x)+(particle.y-p.y)
			if dist<particle.mindist then
				particle.mindist=dist
				particle.closest=j
			end
		end
	end
end

function love.draw()
	for i,particle in ipairs(particles) do
		love.graphics.setColor(particle.color)
		love.graphics.circle("fill",particle.x,particle.y,particle.size)
		love.graphics.line(prevparticle.x,prevparticle.y,particle.x,particle.y)
		prevparticle=particle
	end
end

function AddParticle(x,y,size,color,dx,dy)
	particles[#particles+1]={x=x,y=y,size=size,color=color,dx=dx,dy=dy,closest=1,mindist=1}
end

function Clamp(value,min,max)
	return math.max(math.min(value,max),min)
end

function love.mousepressed(x,y,button,istouch,presses)
	AddParticle(x,y,math.random(5,20),{math.random(),math.random(),math.random()},math.random(-30,30),math.random(-30,30))
end