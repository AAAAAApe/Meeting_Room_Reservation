package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.edu.entity.course.CourseSelection;
import com.edu.mapper.CourseSelectionMapper;
import com.github.jeffreyning.mybatisplus.service.MppServiceImpl;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 选课服务实现类
 * 处理学生选课、退课、查询选课记录和成绩管理等业务逻辑
 * 继承自MppServiceImpl以支持复合主键的操作
 */
@Service
public class CourseSelectionServiceImpl extends MppServiceImpl<CourseSelectionMapper, CourseSelection> implements CourseSelectionService {
    /**
     * 选课数据访问对象，用于操作数据库中的选课记录
     */
    private final CourseSelectionMapper courseSelectionMapper;

    /**
     * 构造函数，通过依赖注入初始化选课数据访问对象
     * @param courseSelectionMapper 选课数据访问对象
     */
    public CourseSelectionServiceImpl(CourseSelectionMapper courseSelectionMapper) {
        this.courseSelectionMapper = courseSelectionMapper;
    }

    /**
     * 学生选课方法
     * 如果选课记录中没有设置选课时间，则自动设置为当前时间
     * 通过调用父类的save方法将选课记录保存到数据库
     * 
     * @param courseSelection 选课信息对象，包含课程ID、学生ID和教师ID等信息
     * @return 选课是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean selectCourse(CourseSelection courseSelection) {
        // 设置选课时间
        if (courseSelection.getSelectionTime() == null) {
            courseSelection.setSelectionTime(LocalDateTime.now());
        }
        return save(courseSelection);
    }

    /**
     * 学生退选课程方法
     * 根据课程ID、学生ID和教师ID创建选课对象，然后调用父类的removeById方法删除对应的选课记录
     * 由于使用了复合主键，需要设置所有主键字段才能正确删除记录
     * 
     * @param courseId 课程ID，选课记录的主键之一
     * @param studentId 学生ID，选课记录的主键之一
     * @param teacherId 教师ID，选课记录的主键之一
     * @return 退选是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean dropCourse(String courseId, String studentId, String teacherId) {
        CourseSelection courseSelection = new CourseSelection();
        courseSelection.setCourseId(courseId);
        courseSelection.setStudentId(studentId);
        courseSelection.setTeacherId(teacherId);
        return removeById(courseSelection);
    }

    /**
     * 获取学生已选课程列表方法
     * 根据学生ID查询该学生所有的选课记录
     * 使用MyBatis-Plus的LambdaQueryWrapper构建查询条件
     * 
     * @param studentId 学生ID，用于筛选特定学生的选课记录
     * @return 返回该学生的所有选课记录列表
     */
    @Override
    public List<CourseSelection> getStudentCourses(String studentId) {
        LambdaQueryWrapper<CourseSelection> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(CourseSelection::getStudentId, studentId);
        return courseSelectionMapper.selectList(queryWrapper);
    }

    /**
     * 获取教师教授的课程列表方法
     * 根据教师ID查询该教师所有的授课记录
     * 使用MyBatis-Plus的LambdaQueryWrapper构建查询条件
     * 
     * @param teacherId 教师ID，用于筛选特定教师的授课记录
     * @return 返回该教师的所有授课记录列表
     */
    @Override
    public List<CourseSelection> getTeacherCourses(String teacherId) {
        LambdaQueryWrapper<CourseSelection> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(CourseSelection::getTeacherId, teacherId);
        return courseSelectionMapper.selectList(queryWrapper);
    }

    /**
     * 更新学生成绩方法
     * 根据课程ID、学生ID和教师ID创建选课对象，设置新的成绩，然后更新数据库记录
     * 由于使用了复合主键，需要设置所有主键字段才能正确更新记录
     * 
     * @param courseId 课程ID，选课记录的主键之一
     * @param studentId 学生ID，选课记录的主键之一
     * @param teacherId 教师ID，选课记录的主键之一
     * @param score 新的成绩值
     * @return 更新是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean updateScore(String courseId, String studentId, String teacherId, Double score) {
        CourseSelection courseSelection = new CourseSelection();
        courseSelection.setCourseId(courseId);
        courseSelection.setStudentId(studentId);
        courseSelection.setTeacherId(teacherId);
        courseSelection.setScore(score);
        return updateById(courseSelection);
    }
}