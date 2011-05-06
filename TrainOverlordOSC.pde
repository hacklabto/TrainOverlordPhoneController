/**
* Control Train Overlord from your smart phone over wifi+xbee
* This configuration uses XBee installed on MakerBot PC. To use Xbee on 
* your PC change the value of 'xbeePortName' to your xbee address.
* to learn more about touchosc see http://hexler.net/touchosc
*/

import oscP5.*;
import netP5.*;
import processing.serial.*;

OscP5 oscP5;
Serial xbeeSerial;
int inPort = 8000;  // This should match to outPort on your smart phone
String xbeePortName = "/dev/ttyUSB0"; // address of the xbee on Maker Bot PC
//String xbeePortName = "/dev/tty.usbserial-A600e0Ui";
float val;
int valx,valy;

//String portName = "/dev/tty.usbserial-A800ejhf";
boolean logEnabled = true; // set to false to turn off logging

String OSC_PREFIX           = "/TOControl/";
String FWD_ONE_SEC          = OSC_PREFIX + "fwdOneSecBtn";
String FWD_TILL_STOP        = OSC_PREFIX + "fwdTillStpBtn";
String BCK_TILL_STOP        = OSC_PREFIX + "bckTillStpBtn";
String BCK_ONE_SEC          = OSC_PREFIX + "bckOneSecBtn";
String STOP_TRAIN           = OSC_PREFIX + "stpTrainBtn";
String UP_ONE_SEC           = OSC_PREFIX + "upOneSecBtn";
String UP_TILL_STOP         = OSC_PREFIX + "upTillStpBtn";
String DWN_TILL_STOP        = OSC_PREFIX + "dwnTillStpBtn";
String DWN_ONE_SEC          = OSC_PREFIX + "dwnOneSecBtn";
String STOP_WINCH           = OSC_PREFIX + "stpWinchBtn";
String RESET                = OSC_PREFIX + "resetBtn";
String STOP_ALL             = OSC_PREFIX + "stopAllBtn";
String MOVE_TILL_IR_TRIGGER = OSC_PREFIX + "mvTillIrTgl";
String PAN_TILT_CONTROL     = OSC_PREFIX + "panTiltCtrl";
String LASER                = OSC_PREFIX + "laser";
String LASERTP              = OSC_PREFIX + "laserxy";
String TILT_UP              = OSC_PREFIX + "tiltUp";
String TILT_DOWN            = OSC_PREFIX + "tiltDown";
String PAN_UP               = OSC_PREFIX + "panUp";
String PAN_DOWN             = OSC_PREFIX + "panDown";


void setup()
{
  oscP5 = new OscP5(this, inPort);
  xbeeSerial = new Serial(this, xbeePortName, 9600);
}

void oscEvent(OscMessage theOscMessage) {
  theOscMessage.print();
    String addr = theOscMessage.addrPattern();
    val  = theOscMessage.get(0).floatValue();
    if (xbeeSerial != null) 
    {
      if (val == 1) // only send a message on button pressed
      {
        if(addr.equals(FWD_ONE_SEC))       
        { 
            send("f");
        } 
        else if (addr.equals(FWD_TILL_STOP))       
        { 
            send("F");
        } 
        else if (addr.equals(BCK_TILL_STOP))       
        { 
            send("B");
        } 
        else if (addr.equals(BCK_ONE_SEC))       
        { 
            send("b");
        } 
        else if (addr.equals(STOP_TRAIN))       
        { 
            send("s");
        } 
        else if (addr.equals(UP_ONE_SEC))       
        { 
            send("u");
        } 
        else if (addr.equals(UP_TILL_STOP))       
        { 
            send("U");
        } 
        else if (addr.equals(DWN_TILL_STOP))       
        { 
            send("M");
        } 
        else if (addr.equals(PAN_UP))       
        { 
            send("P");
        }
        else if (addr.equals(PAN_DOWN))       
        { 
            send("p");
        }
        else if (addr.equals(TILT_UP))       
        { 
            send("T");
        }
        else if (addr.equals(TILT_DOWN))       
        { 
            send("t");
        }
        else if (addr.equals(DWN_ONE_SEC))       
        { 
            send("m");
        } 
        else if (addr.equals(STOP_WINCH))       
        { 
            send("j");
        } 
        else if (addr.equals(RESET))       
        { 
            send("R");
        } 
        else if (addr.equals(STOP_ALL))       
        { 
            send("S");
        }
      }
      // Non-plain-buttons:
       if(addr.equals(LASER))       
        { //Laser power is a toggle:
          if (val == 0)
            send("l");
          else
            send("L");
        } 
       if(addr.equals("/1/xy")) // LASER TILT AND PAN
       {
           valx  = (int)((theOscMessage.get(0).floatValue() *70) + 20);
           valy  = (int)(theOscMessage.get(1).floatValue() * 165 );
           send("t");
           send(""+nf(valx,3));
           send("p");
           send (""+nf(valy,3));
       
       }
    }
    
}


void send(String msg)
{
  xbeeSerial.write(msg);

  if (logEnabled)
  {
    println(msg); 
  }
  
}

void draw()
{
 
}
