class Message
    def self.not_found(record = 'record')
      "Sorry, #{record} not found."
    end
  
    def self.invalid_credentials
      'Invalid credentials'
    end
  
    def self.invalid_token
      'Invalid token'
    end
  
    def self.missing_token
      'Missing token'
    end
  
    def self.unauthorized
      'Unauthorized request'
    end

    def self.unauthorized_to_non_root 
      'Unauthorized for non-root user'
    end
  
    def self.account_created
      'Account created successfully'
    end
  
    def self.account_not_created
      'Account could not  be created'
    end
  
    def self.expired_token
      'Sorry, your token has expired. Please login to continue.'
    end

    def self.updated_user
      'User updated successfully'
    end

    def self.updated
      'Updated successfully'
    end

    def self.unprocessable_entity
      'Object could not be processed'
    end
  
  end