import { serve } from 'https://deno.land/std@0.177.0/http/server.ts';
import Stripe from 'npm:stripe';
// Get the allowed origin from environment variable, default to '*' for development
const ALLOWED_ORIGIN = Deno.env.get("ALLOWED_ORIGIN") || '*';
serve(async (req)=>{
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response(null, {
      headers: {
        'Access-Control-Allow-Origin': ALLOWED_ORIGIN,
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization'
      }
    });
  }
  try {
    const stripeSecret = Deno.env.get("STRIPE_SECRET_KEY");
    console.log("Stripe secret key exists:", !!stripeSecret); // Debug log
    if (!stripeSecret) {
      return new Response(JSON.stringify({
        error: "Stripe secret not set",
        debug: "Please set STRIPE_SECRET_KEY in your Supabase project settings"
      }), {
        status: 500,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': ALLOWED_ORIGIN
        }
      });
    }
    const stripe = new Stripe(stripeSecret, {
      apiVersion: '2022-11-15'
    });
    const body = await req.json();
    // Validate amount (no minimum requirement)
    if (!body.amount || typeof body.amount !== "number" || body.amount <= 0) {
      return new Response(JSON.stringify({
        error: "Invalid amount"
      }), {
        status: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': ALLOWED_ORIGIN
        }
      });
    }
    // Validate currency (only BGN and EUR allowed)
    const currency = body.currency || 'eur';
    if (!['bgn', 'eur'].includes(currency.toLowerCase())) {
      return new Response(JSON.stringify({
        error: "Invalid currency. Only BGN and EUR are supported."
      }), {
        status: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': ALLOWED_ORIGIN
        }
      });
    }
    // Create payment intent with the validated amount and currency
    const paymentIntent = await stripe.paymentIntents.create({
      amount: body.amount,
      currency: currency.toLowerCase()
    });
    return new Response(JSON.stringify({
      clientSecret: paymentIntent.client_secret
    }), {
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': ALLOWED_ORIGIN
      },
      status: 200
    });
  } catch (err) {
    console.error("Error in payment intent creation:", err); // Debug log
    return new Response(JSON.stringify({
      error: err.message,
      debug: "Check server logs for more details"
    }), {
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': ALLOWED_ORIGIN
      },
      status: 500
    });
  }
});