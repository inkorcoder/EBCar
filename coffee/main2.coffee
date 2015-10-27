init = ->
  container = document.createElement("div")
  document.body.appendChild container
  
  # CAMERAS
  camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 0.1, 100000)
  cameraCube = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 0.0001, 1000000)
  
  # SCENE
  scene = new THREE.Scene()
  sceneCube = new THREE.Scene()
  
  # LIGHTS
  ambient = new THREE.AmbientLight(0x000000)
  scene.add ambient
  
  # var lig = new THREE.PointLight( 0xff0000, 1, 1000 );
  # lig.position.set(0, 500, 0);
  # scene.add( lig );
  cube = new THREE.Mesh(new THREE.BoxGeometry(100, 100, 100), new THREE.MeshPhongMaterial(
    color: 0x000000
    side: THREE.BackSide
  ))
  sc = 150
  cube.position.y = -700
  cube.scale.set sc, sc, sc
  scene.add cube
  scene.add light
  axisHelper = new THREE.AxisHelper(5000)
  scene.add axisHelper
  shader = THREE.ShaderLib["cube"]
  shader.uniforms["tCube"].value = textureCube
  material = new THREE.ShaderMaterial(
    fragmentShader: shader.fragmentShader
    vertexShader: shader.vertexShader
    uniforms: shader.uniforms
    depthWrite: false
    side: THREE.BackSide
  )
  mesh = new THREE.Mesh(new THREE.BoxGeometry(10, 10, 10), material)
  sceneCube.add mesh
  plane.rotation.x = deg2rad(-90)
  plane.receiveShadow = false
  plane.receiveShadow = true
  scene.add plane
  renderer = new THREE.WebGLRenderer()
  renderer.setPixelRatio window.devicePixelRatio
  renderer.setSize window.innerWidth, window.innerHeight
  renderer.setFaceCulling THREE.CullFaceNone
  renderer.autoClear = false
  renderer.shadowMapSoft = true
  renderer.shadowMap.enabled = true
  renderer.shadowMap.type = THREE.PCFSoftShadowMap
  container.appendChild renderer.domElement
  document.addEventListener "mousemove", onDocumentMouseMove, false
  CAR.materials = body: [ [ "Orange metal", MATERIALS["Orange metal"] ], [ "Blue metal", MATERIALS["Blue metal"] ], [ "Red metal", MATERIALS["Red metal"] ], [ "Green metal", MATERIALS["Green metal"] ], [ "Black metal", MATERIALS["Black metal"] ], [ "Gold", MATERIALS["Gold"] ], [ "Bronze", MATERIALS["Bronze"] ], [ "Chrome", MATERIALS["Chrome"] ] ]
  m = CAR.materials
  mi = CAR.init_material
  CAR.mmap =
    0: MATERIALS["Black rough"]
    1: MATERIALS["Pure chrome"]
    2: m.body[mi][1]
    3: MATERIALS["Dark glass"]
    4: MATERIALS["Pure chrome"]
    5: MATERIALS["Pure chrome"]
    6: MATERIALS["Red glass 50"]
    7: MATERIALS["Orange glass 50"]

  loader.load CAR.url, (geometry) ->
    createScene geometry, "veyron"

  window.addEventListener "resize", onWindowResize, false
onWindowResize = ->
  windowHalfX = window.innerWidth / 2
  windowHalfY = window.innerHeight / 2
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()
  cameraCube.aspect = window.innerWidth / window.innerHeight
  cameraCube.updateProjectionMatrix()
  renderer.setSize window.innerWidth, window.innerHeight
createScene = (geometry, car) ->
  m = new THREE.MeshFaceMaterial()
  s = CAR.scale * 1
  r = CAR.init_rotation
  materials = CAR.materials
  mi = CAR.init_material
  bm = CAR.body_materials
  for i of CAR.mmap
    m.materials[i] = CAR.mmap[i]
  mesh = new THREE.Mesh(geometry, m)
  mesh.rotation.x = r[0]
  mesh.rotation.y = r[1]
  mesh.rotation.z = r[2]
  mesh.scale.x = mesh.scale.y = mesh.scale.z = s
  scene.add mesh
  mesh.castShadow = true
  CAR.object = mesh
onDocumentMouseMove = (event) ->
  mouseY = (event.clientY - window.innerHeight)
  mouseX = (event.clientX - window.innerWidth)
animate = ->
  requestAnimationFrame animate
  render()
render = ->
  timer = -0.0005 * Date.now()
  camera.position.x = 0
  camera.position.y = (-mouseY - 300) * 2
  camera.position.z = 1000
  
  # camera.position.x = ( - mouseX - 300 ) * 2;
  # camera.position.z = ( - mouseX - 300 ) * 2;
  camera.lookAt scene.position
  cameraCube.rotation.copy camera.rotation
  renderer.render sceneCube, cameraCube
  renderer.render scene, camera
Detector.addGetWebGLMessage()  unless Detector.webgl
CAR =
  name: "Bugatti Veyron"
  url: "obj/veyron/VeyronNoUv_bin.js"
  init_rotation: [ 0, 0, 0 ]
  scale: 5
  init_material: 4
  body_materials: [ 2 ]
  object: null
  buttons: null
  materials: null

container = undefined
stats = undefined
camera = undefined
scene = undefined
renderer = undefined
cameraCube = undefined
sceneCube = undefined
m = undefined
mi = undefined
directionalLight = undefined
pointLight = undefined
mouseX = 0
mouseY = 0
windowHalfX = window.innerWidth / 2
windowHalfY = window.innerHeight / 2
loader = new THREE.BinaryLoader()
init()
animate()