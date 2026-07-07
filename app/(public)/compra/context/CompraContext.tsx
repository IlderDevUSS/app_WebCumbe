"use client";

import React, { createContext, useContext, useState, useRef, useEffect } from 'react';

type CompraContextType = {
  step: number;
  setStep: (step: number) => void;
  loading: boolean;
  setLoading: (loading: boolean) => void;
  
  // Step 1
  locations: any[];
  setLocations: (locs: any[]) => void;
  originId: string;
  setOriginId: (id: string) => void;
  destinationId: string;
  setDestinationId: (id: string) => void;
  date: string;
  setDate: (date: string) => void;
  errorStep1: string;
  setErrorStep1: (error: string) => void;

  // Step 2
  trips: any[];
  setTrips: (trips: any[]) => void;
  selectedTrip: any | null;
  setSelectedTrip: (trip: any) => void;

  // Step 3
  seats: any[];
  setSeats: (seats: any[]) => void;
  selectedSeats: any[];
  setSelectedSeats: React.Dispatch<React.SetStateAction<any[]>>;

  // Step 4
  paymentSuccess: boolean;
  setPaymentSuccess: (success: boolean) => void;
  ticketResult: any[] | null;
  setTicketResult: (tickets: any[] | null) => void;
  pasajeros: Record<string, any>;
  setPasajeros: React.Dispatch<React.SetStateAction<Record<string, any>>>;
  paymentError: string | null;
  setPaymentError: (error: string | null) => void;
  timeLeft: number;
  setTimeLeft: React.Dispatch<React.SetStateAction<number>>;
  userProfile: any;
  setUserProfile: (profile: any) => void;
  
  // Handlers
  handleOriginChange: (val: string) => void;
  handleDestinationChange: (val: string) => void;
};

const CompraContext = createContext<CompraContextType | null>(null);

export function CompraProvider({ children }: { children: React.ReactNode }) {
  const [step, setStep] = useState(1);
  const [loading, setLoading] = useState(false);

  const [locations, setLocations] = useState<any[]>([]);
  const [originId, setOriginId] = useState("");
  const [destinationId, setDestinationId] = useState("");
  
  const [peruDate] = useState(() => {
    const options = { timeZone: "America/Lima", year: "numeric", month: "2-digit", day: "2-digit" } as const;
    const formatter = new Intl.DateTimeFormat("en-US", options);
    const parts = formatter.formatToParts(new Date());
    const year = parts.find(p => p.type === "year")?.value;
    const month = parts.find(p => p.type === "month")?.value;
    const day = parts.find(p => p.type === "day")?.value;
    return `${year}-${month}-${day}`;
  });
  
  const [date, setDate] = useState(peruDate);
  const [errorStep1, setErrorStep1] = useState("");

  const [trips, setTrips] = useState<any[]>([]);
  const [selectedTrip, setSelectedTrip] = useState<any | null>(null);

  const [seats, setSeats] = useState<any[]>([]);
  const [selectedSeats, setSelectedSeats] = useState<any[]>([]);

  const [paymentSuccess, setPaymentSuccess] = useState(false);
  const [ticketResult, setTicketResult] = useState<any[] | null>(null);
  const [pasajeros, setPasajeros] = useState<Record<string, any>>({});
  const [paymentError, setPaymentError] = useState<string | null>(null);
  const [timeLeft, setTimeLeft] = useState(480);
  const [userProfile, setUserProfile] = useState<any>(null);

  const handleOriginChange = (val: string) => {
    if (val && val === destinationId) setDestinationId(originId);
    setOriginId(val);
  };

  const handleDestinationChange = (val: string) => {
    if (val && val === originId) setOriginId(destinationId);
    setDestinationId(val);
  };

  return (
    <CompraContext.Provider value={{
      step, setStep, loading, setLoading,
      locations, setLocations, originId, setOriginId, destinationId, setDestinationId,
      date, setDate, errorStep1, setErrorStep1,
      trips, setTrips, selectedTrip, setSelectedTrip,
      seats, setSeats, selectedSeats, setSelectedSeats,
      paymentSuccess, setPaymentSuccess, ticketResult, setTicketResult,
      pasajeros, setPasajeros, paymentError, setPaymentError,
      timeLeft, setTimeLeft, userProfile, setUserProfile,
      handleOriginChange, handleDestinationChange
    }}>
      {children}
    </CompraContext.Provider>
  );
}

export function useCompra() {
  const context = useContext(CompraContext);
  if (!context) throw new Error("useCompra must be used within a CompraProvider");
  return context;
}
