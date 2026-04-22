-- Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    profile_picture TEXT,
    ktp TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SKCK Table
CREATE TABLE skck (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    applicant_name VARCHAR(255) NOT NULL,
    place_date_birth VARCHAR(255),
    complete_address TEXT,
    needs TEXT,
    id_number VARCHAR(100),
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verification_status VARCHAR(50) DEFAULT 'pending',
    sex VARCHAR(20),
    nationality VARCHAR(100),
    religion VARCHAR(50),
    job VARCHAR(100),
    passport_photo TEXT,
    officer_in_charge INTEGER REFERENCES users(id),
    officer_notes TEXT
);

-- Messages Table (Socket Chat)
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    session_id INTEGER,
    sender_id INTEGER REFERENCES users(id),
    sender_role VARCHAR(50),
    message TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lost Report Letter Table (surat_laporan_kehilangan)
CREATE TABLE lost_report_letter (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    reporter_name VARCHAR(255) NOT NULL,
    contact_reporter VARCHAR(50),
    item_type VARCHAR(255),
    date_lost TIMESTAMP,
    chronology TEXT,
    status_handling VARCHAR(50) DEFAULT 'pending',
    religion VARCHAR(50),
    job VARCHAR(100),
    address TEXT,
    officer_in_charge INTEGER REFERENCES users(id),
    police_number VARCHAR(100),
    date_closed TIMESTAMP
);

-- Crowd Permit Letter Table (surat_izin_keramaian)
CREATE TABLE crowd_permit_letter (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    organizer_name VARCHAR(255) NOT NULL,
    event_name VARCHAR(255),
    event_description TEXT,
    event_start TIMESTAMP,
    event_end TIMESTAMP,
    location TEXT,
    guest_estimate VARCHAR(100),
    levy_fees VARCHAR(100),
    form_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    job VARCHAR(100),
    address TEXT,
    religion VARCHAR(50),
    officer_in_charge INTEGER REFERENCES users(id),
    status_handling VARCHAR(50) DEFAULT 'pending'
);

-- Community Complaints Table (pengaduan_masyarakat)
CREATE TABLE community_complaints (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    complainant_name VARCHAR(255) NOT NULL,
    contact VARCHAR(50),
    complainant_address TEXT,
    complaint_category VARCHAR(100),
    complaint_title VARCHAR(255),
    complaint_content TEXT,
    proof TEXT,
    complaint_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    complaint_status VARCHAR(50) DEFAULT 'pending',
    complainant_job VARCHAR(100),
    complainant_religion VARCHAR(50),
    complainant_nationality VARCHAR(100),
    complainant_loss VARCHAR(255),
    sex VARCHAR(20),
    officer_in_charge INTEGER REFERENCES users(id),
    result TEXT
);

-- Notes Table (catatan)
CREATE TABLE notes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    officer_id INTEGER REFERENCES users(id),
    officer_name VARCHAR(255),
    officer_note TEXT,
    date DATE,
    time TIME,
    related_field VARCHAR(255),
    correction_link TEXT
);

-- News Table (berita)
CREATE TABLE news (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    excerpt TEXT,
    content TEXT,
    author_id INTEGER REFERENCES users(id),
    category VARCHAR(100),
    url_gambar_unggulan TEXT,
    status VARCHAR(50) DEFAULT 'draft',
    published_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
