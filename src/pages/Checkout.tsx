import React from 'react';
import PaymentForm from '../components/PaymentForm';

const Checkout = () => {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-8 text-center">Checkout</h1>
      <PaymentForm />
    </div>
  );
};

export default Checkout; 