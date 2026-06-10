-- 1. Create the Bookings Table
CREATE TABLE bookings (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  guest_name TEXT NOT NULL,
  guest_phone TEXT,
  room_number TEXT NOT NULL,
  check_in_date DATE NOT NULL,
  check_in_time TIME,
  check_out_date DATE NOT NULL,
  check_out_time TIME,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

-- 3. Policy: Allow anyone (anon) to insert new bookings (Public Guest UI)
CREATE POLICY "Allow anonymous insert" ON bookings
  FOR INSERT 
  TO anon
  WITH CHECK (true);

-- 4. Policy: Allow anyone to view bookings to check availability (Public Guest UI)
CREATE POLICY "Allow anonymous select for availability" ON bookings
  FOR SELECT 
  TO anon
  USING (true);

-- 5. Policy: Allow authenticated users (Owner) full access
CREATE POLICY "Allow authenticated full access" ON bookings
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- 6. Enable Realtime on the bookings table
alter publication supabase_realtime add table bookings;
