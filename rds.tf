# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.project_name}-${var.environment}-database-subnets"
  subnet_ids  = [aws_subnet.private_data_subnet_az1.id, aws_subnet.private_data_subnet_az2.id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# get information about a database snapshot
data "aws_db_snapshot" "latest_db_snapshot" {
  db_snapshot_identifier = var.database_snapshot_identifier
  most_recent            = true
  snapshot_type          = "manual"
}

# launch an rds instance from a database snapshot
resource "aws_db_instance" "database_instance" {
  instance_class         = var.database_instance_class
  skip_final_snapshot    = true
  availability_zone      = data.aws_availability_zones.available_zones.names[1]
  identifier             = var.database_instance_identifier
  snapshot_identifier    = data.aws_db_snapshot.latest_db_snapshot.id
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  multi_az               = var.multi_az_deployment
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
}


/*
#Instance we created to run for the first time (make migration on it) and took snapshoot from it as 
#when we deploy the projcet again, RDS will be created with the same configurations and endpoint

# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                  = "mysql"
  engine_version          = "8.0.31"
  multi_az                = var.multi_az_deployment
  identifier              = "${var.project_name}-${var.environment}-rds-instance"
  username                = "nada"
  password                = "nada123456"
  instance_class          = var.database_instance_class 
  allocated_storage       = 5
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.database_security_group.id]
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  db_name                 = "carrentaldb"
  skip_final_snapshot     = true
}
*/

