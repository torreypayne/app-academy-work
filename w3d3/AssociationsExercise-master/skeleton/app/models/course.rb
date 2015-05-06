class Course < ActiveRecord::Base
  has_many(
    :enrollments,
    class_name: 'Enrollment',
    foreign_key: :course_id,
    primary_key: :id
  )

  has_many(
    :enrolled_students,
    through: :enrollments,
    source: :user
  )

  belongs_to(
    :prerequisite,
    class_name: 'Course',
    foreign_key: :prereq_id,
    primary_key: :id
  )

  belongs_to(
    :instructor,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :instructor_id
  )
end


# id | name | prereq_id
# 1  | cs101| null
# 2  | cs201| 1
#
#
# cs201 = Course.find(2)
# cs201.prereq
#
#
# -- has_one query
# select
#   courses.*
# from
#   courses
# where
#   id = ?, :id (2)
# limit
#   1
#
# -- belongs_to query
# select
#   courses.*
# from
#   courses
# where
#   id = ?, :prereq_id (1)
