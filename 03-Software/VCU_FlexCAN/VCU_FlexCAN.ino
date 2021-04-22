/*
 * Object Oriented CAN example for Teensy 3.6 with Dual CAN buses 
 * By Collin Kidder. Based upon the work of Pawelsky and Teachop
 * 
 * Both buses are set to 500k to show things with a faster bus.
 * The reception of frames in this example is done via callbacks
 * to an object rather than polling. Frames are delivered as they come in.
 */

#include <FlexCAN.h>

static CAN_message_t msg;
static uint8_t hex[17] = "0123456789abcdef";

class ExampleClass : public CANListener 
{
public:
   void printFrame(CAN_message_t &frame, int mailbox);
   bool frameHandler(CAN_message_t &frame, int mailbox, uint8_t controller); //overrides the parent version so we can actually do something
};

void ExampleClass::printFrame(CAN_message_t &frame, int mailbox)
{
   Serial.print("ID: ");
   Serial.print(frame.id, HEX);
   Serial.print(" Data: ");
   for (int c = 0; c < frame.len; c++)
   {
      Serial.print(frame.buf[c]);
      Serial.write(' ');
   }
   Serial.write('\r');
   Serial.write('\n');
}

bool ExampleClass::frameHandler(CAN_message_t &frame, int mailbox, uint8_t controller)
{
    printFrame(frame, mailbox);

    return true;
}

ExampleClass exampleClass;

// -------------------------------------------------------------
void setup(void)
{
  delay(1000);
  Serial.println(F("Hello Teensy Single CAN Receiving Example With Objects."));

  Can0.begin(1000000);  // Bit rate (1 MBit/s)

  Can0.attachObj(&exampleClass);
  exampleClass.attachGeneralHandler();

  msg.ext = 0; // Identifiant en cas de filters setting extended
  msg.id = 0x123; // l'identifiant en héxadécimal
  msg.len = 8; // taille des donnée transmise en octet (de 0 à 8 octet au maximum)
 // Donnée transmise octet par octet 
  msg.buf[0] = 10; 
  msg.buf[1] = 20;
  msg.buf[2] = 0;
  msg.buf[3] = 100;
  msg.buf[4] = 128;
  msg.buf[5] = 64;
  msg.buf[6] = 32;
  msg.buf[7] = 16;
}


// -------------------------------------------------------------
void loop(void)
{
  delay(10);
  Can0.write(msg);
}
