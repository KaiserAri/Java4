CREATE DATABASE web_servlet;
use web_servlet;
create table sys_role
(
    id          int auto_increment
        primary key,
    role_name   varchar(50)                          not null,
    description varchar(255)                         null,
    status      varchar(255)                         null,
    noted       varchar(255)                         null,
    created_at  datetime default current_timestamp() null,
    is_deleted  bit      default b'0'                null
);

create table sys_user
(
    user_id              int auto_increment
        primary key,
    username             varchar(500)                         null,
    password             varchar(255)                         null,
    ho_va_ten            varchar(255)                         null,
    phone_number         varchar(15)                          null,
    description          varchar(500)                         null,
    role_id              int                                  null,
    is_active            bit      default b'0'                null,
    status               varchar(255)                         null,
    noted                varchar(255)                         null,
    created_at           datetime default current_timestamp() null,
    constraint phone_number
        unique (phone_number)
);

INSERT INTO sys_role (role_name, description, status, noted, created_at, is_deleted)
VALUES
    ('ADMIN', 'Quản trị viên hệ thống - Toàn quyền', 'ACTIVE', 'Quyền cao nhất', NOW(), 0),
    ('STAFF', 'Nhân viên vận hành', 'ACTIVE', 'Hỗ trợ xử lý nghiệp vụ', NOW(), 0),
    ('USER', 'Người dùng cuối / Khách hàng', 'ACTIVE', 'Chỉ xem dữ liệu cá nhân', NOW(), 0);

INSERT INTO sys_user (username, password, ho_va_ten, phone_number, description, role_id, is_active, status, noted, created_at)
VALUES
    ('admin_demo', 'pass_123456', 'Nguyễn Văn Admin', '0901234567', 'Tài khoản quản trị chính', 1, 1, 'ACTIVE', 'Dùng để demo admin', NOW()),
    ('staff_01', 'pass_123456', 'Trần Thị Nhân Viên', '0912345678', 'Nhân viên kho', 2, 1, 'ACTIVE', 'Demo nhân viên', NOW()),
    ('staff_02', 'pass_123456', 'Lê Văn Support', '0923456789', 'Nhân viên hỗ trợ', 2, 1, 'ACTIVE', 'Demo nhân viên 2', NOW()),
    ('user_01', 'pass_123456', 'Phạm Khách Hàng', '0934567890', 'Khách hàng thân thiết', 3, 1, 'ACTIVE', 'Demo user', NOW()),
    ('user_test', 'pass_123456', 'Trần Văn Test', '0988888888', 'Tài khoản đang bị khóa', 3, 0, 'INACTIVE', 'Dùng để test logic khóa tài khoản', NOW());
