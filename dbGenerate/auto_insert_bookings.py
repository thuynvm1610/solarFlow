import random
import mysql.connector
from datetime import datetime, timedelta

# ==================== DATABASE CONFIGURATION ====================
# Thay đổi thông tin kết nối MySQL của bạn ở đây
DB_CONFIG = {
    'host': 'localhost',        # Thay bằng host của bạn
    'user': 'root',             # Thay bằng username MySQL của bạn
    'password': '123456', # Thay bằng password MySQL của bạn
    'database': 'hotel',        # Thay bằng tên database của bạn
    'port': 3306                # Thay nếu port khác
}

# ==================== DATA CONFIGURATION ====================

START_DATE = datetime(2024, 1, 1)
END_DATE = datetime(2026, 2, 16)

CUSTOMER_IDS = list(range(13, 1017))  # 13 to 1016
HOTEL_IDS = list(range(1, 11))  # 1 to 10

HOTEL_ROOMS = {
    1: list(range(1, 32)),      # Hotel 1: 31 rooms
    2: list(range(32, 62)),     # Hotel 2: 30 rooms
    3: list(range(62, 75)),     # Hotel 3: 13 rooms
    4: list(range(75, 98)),     # Hotel 4: 23 rooms
    5: list(range(98, 116)),    # Hotel 5: 18 rooms
    6: list(range(116, 128)),   # Hotel 6: 12 rooms
    7: list(range(128, 159)),   # Hotel 7: 31 rooms
    8: list(range(159, 172)),   # Hotel 8: 13 rooms
    9: list(range(172, 180)),   # Hotel 9: 8 rooms
    10: list(range(180, 195)),  # Hotel 10: 15 rooms (194 total)
}

ROOM_TYPE_PRICES = {
    1: 362572, 2: 387000, 3: 443571, 4: 548228,
    5: 1359714, 6: 1509208,
    7: 602579, 8: 1350649,
    9: 597817, 10: 689503, 11: 689503, 12: 1089000, 13: 1149172,
    14: 2888963, 15: 3509610, 16: 5207904,
    17: 3582411, 18: 2600000,
    19: 1949360, 20: 2524860, 21: 2100000, 22: 2100000,
    23: 766359, 24: 1287379, 25: 1331771, 26: 2841112, 27: 3196250,
    28: 443012,
    29: 1036364, 30: 1554345, 31: 2117143
}

EXTRA_SERVICES = {
    26: (120000, 250000, 1),
    27: (400000, 1500000, 4),
    28: (70000, 180000, 4),
    29: (230000, 600000, 4),
    30: (850000, 2500000, 2),
    31: (130000, 350000, 3),
    32: (220000, 600000, 3),
    35: (250000, 1200000, 5),
}

STATUSES = ['CHECKED_OUT', 'CANCELLED']
STATUS_WEIGHTS = [0.92, 0.08]

# ==================== HELPER FUNCTIONS ====================

def get_room_type_id(hotel_id, room_id):
    """Get room type ID based on hotel and room ID"""
    room_ranges = {
        1: [(1, 14, 1), (15, 21, 2), (22, 27, 3), (28, 31, 4)],
        2: [(32, 51, 5), (52, 61, 6)],
        3: [(62, 68, 7), (69, 74, 8)],
        4: [(75, 82, 9), (83, 87, 10), (88, 91, 11), (92, 94, 12), (95, 97, 13)],
        5: [(98, 105, 14), (106, 111, 15), (112, 115, 16)],
        6: [(116, 123, 17), (124, 127, 18)],
        7: [(128, 142, 19), (143, 150, 20), (151, 154, 21), (155, 158, 22)],
        8: [(159, 162, 23), (163, 165, 24), (166, 167, 25), (168, 169, 26), (170, 171, 27)],
        9: [(172, 179, 28)],
        10: [(180, 187, 29), (188, 191, 30), (192, 194, 31)]
    }
    
    ranges = room_ranges.get(hotel_id, [])
    for start, end, type_id in ranges:
        if start <= room_id <= end:
            return type_id
    return 1

def get_room_price(hotel_id, room_id):
    """Get base price for a room"""
    room_type_id = get_room_type_id(hotel_id, room_id)
    return ROOM_TYPE_PRICES.get(room_type_id, 500000)

def random_date_in_month(year, month, end_date=None):
    """Generate random check-in date in a specific month"""
    if month == 12:
        next_month = datetime(year + 1, 1, 1)
    else:
        next_month = datetime(year, month + 1, 1)
    
    last_day = (next_month - timedelta(days=1)).day
    
    if end_date and year == 2026 and month == 2:
        last_day = min(last_day, 16)
    
    day = random.randint(1, max(1, last_day - 1))
    return datetime(year, month, day)

# ==================== DATABASE OPERATIONS ====================

def connect_db():
    """Connect to MySQL database"""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        print("✓ Connected to MySQL database successfully!")
        return conn
    except mysql.connector.Error as err:
        print(f"✗ Error connecting to database: {err}")
        return None

def clear_existing_data(cursor):
    """Clear existing booking data (optional - uncomment if you want to clear old data)"""
    print("\n⚠️  Clearing existing booking data...")
    try:
        cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
        cursor.execute("DELETE FROM booking_room_services")
        cursor.execute("DELETE FROM booking_rooms")
        cursor.execute("DELETE FROM bookings")
        cursor.execute("ALTER TABLE bookings AUTO_INCREMENT = 1")
        cursor.execute("ALTER TABLE booking_rooms AUTO_INCREMENT = 1")
        cursor.execute("ALTER TABLE booking_room_services AUTO_INCREMENT = 1")
        cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
        print("✓ Existing data cleared!")
    except mysql.connector.Error as err:
        print(f"✗ Error clearing data: {err}")

def insert_booking(cursor, booking):
    """Insert a single booking"""
    sql = """
    INSERT INTO bookings 
    (booking_code, user_id, hotel_id, check_in_date, check_out_date, total_price, status, created_at)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        booking['booking_code'],
        booking['user_id'],
        booking['hotel_id'],
        booking['check_in_date'],
        booking['check_out_date'],
        booking['total_price'],
        booking['status'],
        booking['created_at']
    )
    cursor.execute(sql, values)
    return cursor.lastrowid

def insert_booking_room(cursor, booking_room):
    """Insert a single booking room"""
    sql = """
    INSERT INTO booking_rooms 
    (booking_id, room_id, price_per_night)
    VALUES (%s, %s, %s)
    """
    values = (
        booking_room['booking_id'],
        booking_room['room_id'],
        booking_room['price_per_night']
    )
    cursor.execute(sql, values)
    return cursor.lastrowid

def insert_booking_room_service(cursor, service):
    """Insert a single booking room service"""
    sql = """
    INSERT INTO booking_room_services 
    (booking_room_id, amenity_id, unit_id, unit_price, quantity, total_price)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    values = (
        service['booking_room_id'],
        service['amenity_id'],
        service['unit_id'],
        service['unit_price'],
        service['quantity'],
        service['total_price']
    )
    cursor.execute(sql, values)

# ==================== MAIN GENERATION LOGIC ====================

def generate_and_insert_bookings(conn):
    """Generate and insert bookings directly to database"""
    
    cursor = conn.cursor()
    
    # Optional: Clear existing data
    # Uncomment the line below if you want to clear old bookings first
    # clear_existing_data(cursor)
    
    TARGET_MONTHLY_REVENUE = 1_000_000_000
    current_date = START_DATE
    
    total_bookings = 0
    total_booking_rooms = 0
    total_services = 0
    total_revenue = 0
    
    print("\n" + "=" * 60)
    print("GENERATING AND INSERTING BOOKING DATA")
    print("=" * 60)
    
    try:
        while current_date <= END_DATE:
            year = current_date.year
            month = current_date.month
            
            print(f"\nGenerating bookings for {year}-{month:02d}...")
            
            monthly_revenue = 0
            month_bookings = 0
            
            while monthly_revenue < TARGET_MONTHLY_REVENUE:
                # Generate booking data
                user_id = random.choice(CUSTOMER_IDS)
                hotel_id = random.choice(HOTEL_IDS)
                
                check_in = random_date_in_month(year, month, END_DATE)
                nights = random.randint(1, 7)
                check_out = check_in + timedelta(days=nights)
                
                if check_out > END_DATE:
                    check_out = END_DATE
                    nights = (check_out - check_in).days
                    if nights < 1:
                        nights = 1
                        check_out = check_in + timedelta(days=1)
                        if check_out > END_DATE:
                            continue
                
                num_rooms = random.choices([1, 2, 3], weights=[0.6, 0.3, 0.1])[0]
                available_rooms = HOTEL_ROOMS[hotel_id]
                selected_rooms = random.sample(available_rooms, min(num_rooms, len(available_rooms)))
                
                booking_total = 0
                
                # Calculate booking total
                for room_id in selected_rooms:
                    price_per_night = get_room_price(hotel_id, room_id)
                    room_total = price_per_night * nights
                    booking_total += room_total
                
                status = random.choices(STATUSES, weights=STATUS_WEIGHTS)[0]
                booking_code = f'BK{year}{month:02d}{total_bookings + 1:06d}'
                created_at = check_in - timedelta(days=random.randint(1, 30))
                
                # Insert booking
                booking_id = insert_booking(cursor, {
                    'booking_code': booking_code,
                    'user_id': user_id,
                    'hotel_id': hotel_id,
                    'check_in_date': check_in.strftime('%Y-%m-%d'),
                    'check_out_date': check_out.strftime('%Y-%m-%d'),
                    'total_price': booking_total,
                    'status': status,
                    'created_at': created_at.strftime('%Y-%m-%d %H:%M:%S')
                })
                
                # Insert booking rooms and services
                for room_id in selected_rooms:
                    price_per_night = get_room_price(hotel_id, room_id)
                    
                    booking_room_id = insert_booking_room(cursor, {
                        'booking_id': booking_id,
                        'room_id': room_id,
                        'price_per_night': price_per_night
                    })
                    
                    total_booking_rooms += 1
                    
                    # Add extra services (30% chance)
                    if random.random() < 0.3:
                        num_services = random.randint(1, 3)
                        selected_services = random.sample(list(EXTRA_SERVICES.keys()), 
                                                         min(num_services, len(EXTRA_SERVICES)))
                        
                        for amenity_id in selected_services:
                            min_price, max_price, unit_id = EXTRA_SERVICES[amenity_id]
                            unit_price = random.randint(int(min_price), int(max_price))
                            
                            if unit_id == 1:
                                quantity = random.randint(1, 4)
                            elif unit_id in [2, 3]:
                                quantity = nights
                            else:
                                quantity = random.randint(1, 2)
                            
                            service_total = unit_price * quantity
                            booking_total += service_total
                            
                            insert_booking_room_service(cursor, {
                                'booking_room_id': booking_room_id,
                                'amenity_id': amenity_id,
                                'unit_id': unit_id,
                                'unit_price': unit_price,
                                'quantity': quantity,
                                'total_price': service_total
                            })
                            
                            total_services += 1
                
                # Update booking total with services
                cursor.execute(
                    "UPDATE bookings SET total_price = %s WHERE id = %s",
                    (booking_total, booking_id)
                )
                
                monthly_revenue += booking_total
                total_bookings += 1
                month_bookings += 1
                total_revenue += booking_total
                
                # Commit every 50 bookings for performance
                if month_bookings % 50 == 0:
                    conn.commit()
            
            # Commit remaining bookings for this month
            conn.commit()
            
            print(f"  → {month_bookings} bookings | Revenue: {monthly_revenue:,.0f} VND")
            
            # Move to next month
            if month == 12:
                current_date = datetime(year + 1, 1, 1)
            else:
                current_date = datetime(year, month + 1, 1)
        
        print("\n" + "=" * 60)
        print("SUMMARY")
        print("=" * 60)
        print(f"✓ Total bookings inserted: {total_bookings:,}")
        print(f"✓ Total booking rooms inserted: {total_booking_rooms:,}")
        print(f"✓ Total services inserted: {total_services:,}")
        print(f"✓ Total revenue: {total_revenue:,.0f} VND")
        print(f"✓ Average per booking: {total_revenue/total_bookings:,.0f} VND")
        print("=" * 60)
        print("\n✓ All data inserted successfully!")
        
    except mysql.connector.Error as err:
        print(f"\n✗ Database error: {err}")
        conn.rollback()
    except Exception as e:
        print(f"\n✗ Error: {e}")
        conn.rollback()
    finally:
        cursor.close()

# ==================== MAIN ====================

if __name__ == '__main__':
    print("=" * 60)
    print("BOOKING DATA GENERATOR - DIRECT DATABASE INSERT")
    print("=" * 60)
    print(f"\nTarget: >= 1,000,000,000 VND per month")
    print(f"Period: {START_DATE.strftime('%Y-%m-%d')} to {END_DATE.strftime('%Y-%m-%d')}")
    print("\n⚠️  Make sure to update DB_CONFIG with your MySQL credentials!")
    
    input("\nPress Enter to continue...")
    
    # Connect to database
    conn = connect_db()
    
    if conn:
        try:
            # Generate and insert data
            generate_and_insert_bookings(conn)
        finally:
            conn.close()
            print("\n✓ Database connection closed.")
    else:
        print("\n✗ Failed to connect to database. Please check your DB_CONFIG settings.")
