function createSpaceShip()
{
	%spaceship = new Sprite(PlayerShip);
	%spaceship.setBodyType(dynamic);
	%spaceship.Position = "0 0";
	%spaceship.Size = "4 4";
	%spaceship.SceneLayer = 1;
	%spaceship.Image = "krawl:LoRez_SpaceShip";
	%spaceship.createPolygonBoxCollisionShape();
	%spaceship.setCollisionCallback(true);
	myScene.add(%spaceship);
	%spaceship.setFixedAngle(true);
	%spaceship.isThrusting = false;
}

function PlayerShip::onCollision(%this, %sceneobject, %collisiondetails)
{
	if(%sceneobject.getSceneGroup() == 20)
	{
		%explosion = new ParticlePlayer();
		%explosion.Particle = "ToyAssets:impactExplosion";
		%explosion.setPosition(%sceneobject.getPosition());
		%explosion.setSizeScale(2);
		myScene.add(%explosion);
		%sceneobject.safedelete();
		createAsteroids(1);
	}
}

function PlayerShip::accelerate(%this)
{
	%adjustedAngle = %this.Angle;
	if(%adjustedAngle < 0) %adjustedAngle *= -1;
	else if (%adjustedAngle > 0) %adjustedAngle = 360-%adjustedAngle;
	
	%adjustedAngle %= 360;
	
	if(%this.isThrusting)
	{
		%ThrustVector = Vector2Direction(%adjustedAngle,35);
	}
	else
	{
		%ThrustVector = Vector2Direction(%adjustedAngle,95);
		%this.setLinearDamping(0.0);
		%this.setAngularDamping(2.0);
	}
	
	%MywordX = %this.Position.x + %ThrustVector.x;
	%MywordY = %this.Position.y + %ThrustVector.y;
	%this.applyLinearImpulse(%ThrustVector, "0 0");
	%this.isThrusting = true;
	%this.thrustschedule = %this.schedule(100, accelerate);
}

function PlayerShip::turnleft(%this)
{
	%this.setAngularVelocity(%this.getAngularVelocity()+20);
	%this.turnschedule = %this.schedule(100, turnleft);
}

function PlayerShip::turnright(%this)
{
	%this.setAngularVelocity(%this.getAngularVelocity()-20);
	%this.turnschedule = %this.schedule(100, turnright);
}

function PlayerShip::stopturn(%this)
{
	cancel(%this.turnschedule);
	%this.setAngularVelocity(0);
}

function PlayerShip::stopthrust(%this)
{
	%this.setLinearDamping(0.8);
	%this.setAngularDamping(0.0);
	cancel (%this.thrustschedule);
	%this.isThrusting = false;
}