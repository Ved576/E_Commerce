const functions = require("firebase-functions");
const Razorpay = require("razorpay");

// FIXED: Broken the long comment into two lines to pass the max-len rule.
// NOTE: It is still highly recommended to use functions.config()
// instead of hardcoding keys.
const KEY_ID = "rzp_test_ryW0AG51bDcWZc";
const KEY_SECRET = "AHUdULCRQqi4q14B7knG19h1";

const instance = new Razorpay({
  key_id: KEY_ID,
  key_secret: KEY_SECRET,
});

exports.createRazorpayOrder = functions.https.onCall(async (data, context) => {
  const amount = data.amount;

  const options = {
    amount: amount,
    currency: "INR",
  };

  try {
    const order = await instance.orders.create(options);
    console.log("Created Razorpay Order: ", order);
    return {orderId: order.id};
  } catch (error) {
    // FIXED: Broken the long console.error call into multiple lines.
    console.error(
        "Failed to Create Razorpay Order: ",
        error,
    );
    // FIXED: Broken the long 'throw' statement into multiple lines.
    throw new functions.https.HttpsError(
        "internal",
        "Failed to Create Order",
        error,
    );
  }
});

// FIXED: Added a final blank line to satisfy the 'eol-last' rule.
