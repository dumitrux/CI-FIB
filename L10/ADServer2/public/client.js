// ***************************************************************************
//
// ***************************************************************************

var socket = io();		     


var TO_RADIANS = Math.PI/180; 

var canvas;
var ctx;
var img = new Image();
img.src='img/protractor2.png';
var imgHandle=new Image();
imgHandle.src='img/handle.png';
var trajectory=[];


// ***************************************************************************
// Window Load handler
// ***************************************************************************
window.onload = function() 
{
 canvas = document.getElementById("myCanvas");
 ctx=canvas.getContext("2d");
 canvas.width  = img.width;
 canvas.height = img.height;
 draw_angle(0);


}

// ***************************************************************************
// Get data button handler
// ***************************************************************************
function sendData() 
{
  socket.emit('message', 'GETDATA\n');
}

// ***************************************************************************
// Restart button handler
// ***************************************************************************
function sendInit() 
{
  socket.emit('message', 'RESTART\n');
}

// ***************************************************************************
// Receive Handler function
// ***************************************************************************
socket.on('message', function (data)
{

  var command,val1,val2; 

  // Split packet
  var packet = data.split(','); 
    
  // Packet without parameters...
  if (packet.length == 1)
  {
    // *********************** INIT *********************
    command = packet[0];
	if(command=='INIT') clear();
  }  
  
  // Packet with one parameter ...
  else if (packet.length == 2) 
  {
    command = packet[0];              
    val1 = packet[1]; 
	
	// NO COMMANDS...
  }
  
  // Packet with two parameter ... 
  else if (packet.length == 3) 
  {
    command = packet[0];              
    val1 = parseInt(packet[1]); 
	val2 = parseInt(packet[2]);
	
	// *********************** DATA *********************
	if(command=='DATA')
    {		   
	   push_trajectory(val1,val2);
	   draw_angle(val1);
	   draw_trajectory();
      
	}
	
  }
  
  showmsg(data);
  
 });	

// ***************************************************************************
// Shows data into the information Panel
// ***************************************************************************
function showmsg(msg)
{
  document.getElementById('msg').innerHTML=msg;	
}

// ***************************************************************************
// Pushes data point into trajectory vector
// ***************************************************************************	
function push_trajectory(ang,dist)
{
  trajectory.push({angle:ang, distance:dist});
	
}

// ***************************************************************************	
// Clears trajectory
// ***************************************************************************	
function clear()
{
  trajectory=[];
  draw_angle(0);
  document.getElementById('label').innerHTML=String("(0º,0mm)");	

}


// ***************************************************************************
// Draws angle pointer
// ***************************************************************************
function draw_angle(degree)
{
 ctx.clearRect(0, 0, canvas.width, canvas.height);
 ctx.drawImage(img,0,0);
 //ctx.save(); 
 //ctx.translate((canvas.width/2),0); 
 //ctx.rotate(90-degree*TO_RADIANS); 
 //ctx.drawImage(imgHandle,-imgHandle.width/2,-6);
 //ctx.restore();

  degree=90-degree;
  
  var ll=imgHandle.height-20;
  var xx=ll*Math.sin(degree*TO_RADIANS);
  var yy=ll*Math.cos(degree*TO_RADIANS);
  
  ctx.beginPath();
  ctx.moveTo((canvas.width/2),0);
  ctx.lineTo((canvas.width/2)+xx,yy);
  ctx.lineWidth = 1;
  ctx.strokeStyle = '#ffff00';
  ctx.stroke();
    
}
	
// ***************************************************************************
// Draws trajectory 
// ***************************************************************************
function draw_trajectory()
{
  ctx.save(); 
  var a,d,ll,xx,yy;
  ctx.translate((canvas.width/2),0); 
	
  for(i=0; i< trajectory.length;i++)
  {
    a=(90-trajectory[i].angle)*TO_RADIANS;
	d=trajectory[i].distance;
	ll=((d/200)*(imgHandle.height-57));
	xx=ll*Math.sin(a);
    yy=ll*Math.cos(a);
    ctx.strokeStyle = '#00ffff'; 
	ctx.strokeRect(xx,yy,1,1); 
  }
 
   ctx.restore();
   document.getElementById('label').innerHTML=String('('+trajectory[trajectory.length-1].angle+'º'+" , " + trajectory[trajectory.length-1].distance+"mm)");	
}