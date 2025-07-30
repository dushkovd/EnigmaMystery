import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { stripe } from './stripe.ts';

// Get the allowed origin from environment variable, default to '*' for development
const ALLOWED_ORIGIN = Deno.env.get("ALLOWED_ORIGIN") || '*';

interface RequestBody {
  amount: number;
  currency: string;
  userId: string;
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response(null, {
      headers: {
        'Access-Control-Allow-Origin': ALLOWED_ORIGIN,
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      },
    });
    }

  try {
    const { amount, currency = 'eur', userId } = await req.json() as RequestBody;

    console.log('Received payment intent request:', { amount, currency, userId }); // Debug log

    if (!amount || amount <= 0) {
      throw new Error('Invalid amount');
    }

    // Create a PaymentIntent with the order amount and currency
    const paymentIntent = await stripe.paymentIntents.create({
      amount,
      currency: currency.toLowerCase(),
      automatic_payment_methods: {
        enabled: true,
      },
      metadata: {
        userId,
      },
    });

    console.log('Created payment intent:', { 
      id: paymentIntent.id, 
      amount: paymentIntent.amount, 
      currency: paymentIntent.currency 
    }); // Debug log

    return new Response(
      JSON.stringify({
        clientSecret: paymentIntent.client_secret,
      }),
      {
      headers: { 'Content-Type': 'application/json' },
      status: 200,
      },
    );
  } catch (error) {
    console.error("Error in payment intent creation:", error); // Debug log
    return new Response(
      JSON.stringify({ error: error.message }),
      {
      headers: { 'Content-Type': 'application/json' },
        status: 400,
      },
    );
  }
});