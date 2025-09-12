-- This script runs automatically when PostgreSQL container starts for the first time

-- Create our tables
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    is_premium BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS resume_analyses (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    original_resume_path VARCHAR(500),
    original_filename VARCHAR(255),
    job_description TEXT NOT NULL,
    match_score INTEGER CHECK (match_score >= 0 AND match_score <= 100),
    analysis_result JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS generated_resumes (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    analysis_id BIGINT NOT NULL,
    generated_resume_path VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (analysis_id) REFERENCES resume_analyses(id)
);

-- Insert a test user (password would be hashed in real app)
INSERT INTO users (email, password, first_name, last_name) 
VALUES ('test@example.com', 'password123', 'Test', 'User')
ON CONFLICT (email) DO NOTHING;

-- Let's add some indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_resume_analyses_user_id ON resume_analyses(user_id);