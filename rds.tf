resource "aws_db_parameter_group" "rox_api_mysql_84" {
  name   = "rox-api-mysql-84"
  family = "mysql8.4"
}  

resource "aws_db_instance" "rox_api_mysql" {
  identifier              = "rox-api-mysql"
  engine                  = "mysql"
  engine_version          = "8.4"
  instance_class          = "db.m5.large"
  allocated_storage       = 50 # Storage in GB
  db_name                 = "rox_api_database"
  username                = ""
  password                = ""
  parameter_group_name    = aws_db_parameter_group.rox_api_mysql_84.name
  allow_major_version_upgrade = true
  apply_immediately = true
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group_rox_api.name
  vpc_security_group_ids  = [aws_security_group.mysql_sg_rox_api.id]
  backup_retention_period = 7
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = true
}

resource "aws_db_subnet_group" "mysql_subnet_group_rox_api" {
  name       = "mysql-subnet-group-rox_api"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_security_group" "mysql_sg_rox_api" {
  name        = "mysql-security-group-rox_api"
  description = "Security group for mysql RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mysql-security-group-rox_api"
  }
}

resource "aws_db_parameter_group" "policy_manager_mysql_84" {
  name   = "policy-manager-mysql-84"
  family = "mysql8.4"
}

resource "aws_db_instance" "mysql_instance_policy_manager" {
  identifier              = "mysql-instance-policy-manager"
  engine                  = "mysql"
  engine_version          = "8.4"
  instance_class          = "db.t4g.medium"
  db_name                 = "policy_manager_database"
  username                = ""
  password                = ""
  parameter_group_name    = aws_db_parameter_group.policy_manager_mysql_84.name
  allocated_storage       = 50
  vpc_security_group_ids  = [aws_security_group.mysql_sg_policy_manager.id]
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group_policy_manager.name
  publicly_accessible     = false
  multi_az                = true
  skip_final_snapshot     = true
  backup_retention_period = 7
}

resource "aws_db_subnet_group" "mysql_subnet_group_policy_manager" {
  name       = "mysql-subnet-group-policy_manager"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_security_group" "mysql_sg_policy_manager" {
  name        = "mysql-security-group-policy_manager"
  description = "Security group for mysql RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mysql-security-group-policy_manager"
  }
}


