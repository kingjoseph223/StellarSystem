import SceneKit

final class StellarSystemScene: SCNScene {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init () {
        super.init()
        
        rootNode.castsShadow = false
        
        // Content Node
        
        let stellarSystemNode = SCNNode()
        stellarSystemNode.castsShadow = false
        rootNode.addChildNode(stellarSystemNode)
        
        // Sun-group
        
        let sunGroupNode = SCNNode()
        sunGroupNode.castsShadow = false
        sunGroupNode.position = SCNVector3Make(0, 0, 0)
        stellarSystemNode.addChildNode(sunGroupNode)
        
        sunGroupNode.addChildNode(SunLightNode(angle: -Float(Double.pi/2)))
        sunGroupNode.addChildNode(SunLightNode(angle: -Float(Double.pi/4)))
        sunGroupNode.addChildNode(SunLightNode(angle: -Float(Double.pi/8)))
        sunGroupNode.addChildNode(SunLightNode(angle: 0))
        
        let sunNode = SphereNode("sun", radius: 1.5, lightningModel: .constant, duration: 20.0)
        sunGroupNode.addChildNode(sunNode)
        
        // Mercury-group
        let mercuryRotationNode = SphereRotationNode(angle: 0)
        let mercuryNode = SphereNode("mercury", radius: 0.4, position: SCNVector3Make(3, 0, 0))
        mercuryRotationNode.addChildNode(mercuryNode)
        sunGroupNode.addChildNode(mercuryRotationNode)
        
        // Venus-group
        let venusRotationNode = SphereRotationNode(angle: Float(Double.pi/8))
        let venusNode = SphereNode("venus", radius: 0.9, position: SCNVector3Make(6, 0, 0))
        venusRotationNode.addChildNode(venusNode)
        sunGroupNode.addChildNode(venusRotationNode)
        
        // Earth-group (will contain the Earth and the Moon)
        let earthRotationNode = SphereRotationNode(angle: Float(Double.pi/4))
        let earthGroupNode = SphereGroupNode(sphereNode: SphereNode("earth", castsShadow: true, radius: 1.0), position: SCNVector3Make(10, 0, 0))
        let moonNode = SphereNode("moon", castsShadow: true, radius: 0.5, position: SCNVector3Make(2, 0, 0))
        earthGroupNode.addChildNode(SatelliteRotationNode(satelliteNode: moonNode))
        earthRotationNode.addChildNode(earthGroupNode)
        sunGroupNode.addChildNode(earthRotationNode)
        
        // Mars-group (will contain Mars, Phobos and Deimos)
        let marsRotationNode = SphereRotationNode(angle: Float(Double.pi/2))
        let marsGroupNode = SphereGroupNode(sphereNode: SphereNode("mars", radius: 0.8), position: SCNVector3Make(16, 0, 0))
        let phobosNode = SphereNode("moon", castsShadow: true, radius: 0.3, position: SCNVector3Make(2, 0, 0))
        marsGroupNode.addChildNode(SatelliteRotationNode(satelliteNode: phobosNode))
        let deimosNode = SphereNode("moon", castsShadow: true, radius: 0.15, position: SCNVector3Make(4, 0, 0))
        marsGroupNode.addChildNode(SatelliteRotationNode(satelliteNode: deimosNode))
        marsRotationNode.addChildNode(marsGroupNode)
        sunGroupNode.addChildNode(marsRotationNode)
        
        // Borg
        sunGroupNode.addChildNode(BorgNode(position: SCNVector3(3, 3, 0)))
    }
}
