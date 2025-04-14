package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.edu.entity.course.Course;
import com.edu.entity.course.CourseSelection;
import com.edu.entity.course.CourseTeacher;
import com.edu.entity.view.CourseSelectView;
import com.edu.entity.view.CourseView;
import com.edu.entity.view.CourseWithTeacherView;
import com.edu.mapper.*;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 课程服务实现类
 * 处理课程的创建、查询、更新和删除等业务逻辑
 * 继承自ServiceImpl以利用MyBatis-Plus提供的通用CRUD功能
 */
@Service
public class CourseServiceImpl implements CourseService {
    private final CourseMapper courseMapper;
    private final CourseTeacherMapper courseTeacherMapper;
    private final CourseSelectionMapper courseSelectionMapper;
    private final CourseViewMapper courseViewMapper;
    private final CourseSelectViewMapper courseSelectViewMapper;
    private final CourseWithTeacherViewMapper courseWithTeacherViewMapper;

    /**
     * 构造函数，通过依赖注入初始化所有数据访问对象
     *
     * @param courseMapper           课程数据访问对象
     * @param courseTeacherMapper    课程教师关系数据访问对象
     * @param courseSelectionMapper  选课数据访问对象
     * @param courseViewMapper       课程视图数据访问对象
     * @param courseSelectViewMapper 选课视图数据访问对象
     */
    public CourseServiceImpl(CourseMapper courseMapper, CourseTeacherMapper courseTeacherMapper,
            CourseSelectionMapper courseSelectionMapper, CourseViewMapper courseViewMapper,
            CourseSelectViewMapper courseSelectViewMapper, CourseWithTeacherViewMapper courseWithTeacherViewMapper) {
        this.courseMapper = courseMapper;
        this.courseTeacherMapper = courseTeacherMapper;
        this.courseSelectionMapper = courseSelectionMapper;
        this.courseViewMapper = courseViewMapper;
        this.courseSelectViewMapper = courseSelectViewMapper;
        this.courseWithTeacherViewMapper = courseWithTeacherViewMapper;
    }

    /**
     * 根据课程ID获取课程信息
     *
     * @param courseId 课程ID
     * @return 课程信息视图对象
     */
    @Override
    public CourseView getCourseById(String courseId) {
        return courseViewMapper.selectById(courseId);
    }

    /**
     * 根据部门ID获取课程列表（分页）
     *
     * @param departmentId 部门ID
     * @param current      当前页码
     * @param size         每页大小
     * @return 包含分页课程信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<CourseView> getCoursesByDepartmentPage(String departmentId, long current, long size) {
        Page<CourseView> page = new Page<>(current, size);
        return courseViewMapper.selectPage(page,
                new LambdaQueryWrapper<CourseView>().eq(CourseView::getDepartmentId, departmentId));
    }

    /**
     * 根据教师ID获取课程列表（分页）
     *
     * @param teacherId 教师ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 包含分页课程信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<CourseWithTeacherView> getCoursesByTeacherPage(String teacherId, long current, long size) {
        Page<CourseWithTeacherView> page = new Page<>(current, size);
        return courseWithTeacherViewMapper.selectPage(page,
                new LambdaQueryWrapper<CourseWithTeacherView>().eq(CourseWithTeacherView::getTeacherId, teacherId));
    }

    /**
     * 根据学生ID获取课程列表（分页）
     *
     * @param studentId 学生ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 包含分页选课信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<CourseSelectView> getCoursesByStudentPage(String studentId, long current, long size) {
        Page<CourseSelectView> page = new Page<>(current, size);
        return courseSelectViewMapper.selectPage(page,
                new LambdaQueryWrapper<CourseSelectView>().eq(CourseSelectView::getStudentId, studentId));
    }

    /**
     * 获取所有课程（分页）
     *
     * @param current 当前页码
     * @param size    每页大小
     * @return 包含分页课程信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<CourseView> getAllCoursesByPage(long current, long size, List<String> departmentIds) {
        Page<CourseView> page = new Page<>(current, size);
        LambdaQueryWrapper<CourseView> queryWrapper = new LambdaQueryWrapper<>();
        if (departmentIds != null && !departmentIds.isEmpty()) {
            queryWrapper.in(CourseView::getDepartmentId, departmentIds);
        }
        return courseViewMapper.selectPage(page, queryWrapper);
    }

    @Override
    public Page<CourseWithTeacherView> getCourseWithTeachersByCourseId(Integer courseId, long current, long size) {
        Page<CourseWithTeacherView> page = new Page<>(current, size);
        return courseWithTeacherViewMapper.selectPage(page,
                new LambdaQueryWrapper<CourseWithTeacherView>().eq(CourseWithTeacherView::getCourseId, courseId));
    }

    /**
     * 创建或更新课程信息，同时更新课程与教师的关联关系
     *
     * @param course     课程信息
     * @param teacherIds 教师ID列表
     * @return 课程ID
     */
    @Override
    public Integer createOrUpdateCourse(Course course, List<String> teacherIds, String creatorId) {
        course.setCreatorId(creatorId);
        if (courseMapper.insertOrUpdate(course)) {
            // 将teacherIds转换为Set以提高查找效率
            Set<String> teacherIdSet = new HashSet<>(teacherIds);

            // 只有在编辑已存在课程时才执行删除操作
            if (course.getCourseId() != null) {
                // 查询该课程现有的教师关系
                List<CourseTeacher> existingTeachers = courseTeacherMapper.selectList(
                        new LambdaQueryWrapper<CourseTeacher>().eq(CourseTeacher::getCourseId, course.getCourseId()));

                // 删除不再需要的教师关系
                for (CourseTeacher existingTeacher : existingTeachers) {
                    String teacherId = existingTeacher.getUserId();
                    if (!teacherIdSet.contains(teacherId)) {
                        // 使用LambdaQueryWrapper构建删除条件，同时指定courseId和userId
                        courseTeacherMapper.delete(
                                new LambdaQueryWrapper<CourseTeacher>()
                                        .eq(CourseTeacher::getCourseId, course.getCourseId())
                                        .eq(CourseTeacher::getUserId, teacherId));
                    } else {
                        // 从集合中移除已存在的教师ID
                        teacherIdSet.remove(teacherId);
                    }
                }
            }

            // 添加新的教师关系
            for (String teacherId : teacherIdSet) {
                CourseTeacher courseTeacher = new CourseTeacher();
                courseTeacher.setCourseId(course.getCourseId());
                courseTeacher.setUserId(teacherId);
                courseTeacherMapper.insert(courseTeacher);
            }

            return course.getCourseId();
        }
        return null;
    }

    // /**
    //  * 创建或更新课程信息
    //  *
    //  * @param course 课程信息
    //  * @return 课程ID
    //  */
    // @Override
    // public Integer createOrUpdateCourse(Course course, String creatorId) {
    //     course.setCreatorId(creatorId);
    //     if (courseMapper.insertOrUpdate(course)) {
    //         return course.getCourseId();
    //     }
    //     return null;
    // }

    /**
     * 删除课程
     *
     * @param courseId 课程ID
     * @return 是否删除成功
     */
    @Override
    public boolean deleteCourse(Integer courseId) {
        return courseMapper.deleteById(courseId) > 0;
    }

    /**
     * 学生选课
     *
     * @param courseSelection 选课信息（包含课程ID、学生ID和教师ID）
     * @return 是否选课成功
     */
    @Override
    public boolean selectCourse(CourseSelection courseSelection) {
        return courseSelectionMapper.insert(courseSelection) > 0;
    }

    /**
     * 学生退选课程
     *
     * @param courseSelection 选课信息（包含课程ID、学生ID和教师ID）
     * @return 是否退选成功
     */
    @Override
    public boolean dropCourse(CourseSelection courseSelection) {
        return courseSelectionMapper.delete(
                new LambdaQueryWrapper<CourseSelection>()
                        .eq(CourseSelection::getCourseId, courseSelection.getCourseId())
                        .eq(CourseSelection::getStudentId, courseSelection.getStudentId())) > 0;
    }

    /**
     * 获取学生已选课程列表
     *
     * @param studentId 学生ID
     * @return 已选课程列表
     */
    @Override
    public List<CourseSelectView> getStudentCourses(String studentId) {
        return courseSelectViewMapper.selectList(new LambdaQueryWrapper<CourseSelectView>()
                .eq(CourseSelectView::getStudentId, studentId));
    }

    /**
     * 获取学生已选课程列表（分页）
     *
     * @param studentId 学生ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页已选课程列表
     */
    @Override
    public Page<CourseSelectView> getStudentCoursesPage(String studentId, long current, long size) {
        Page<CourseSelectView> page = new Page<>(current, size);
        return courseSelectViewMapper.selectPage(page, new LambdaQueryWrapper<CourseSelectView>()
                .eq(CourseSelectView::getStudentId, studentId));
    }

    /**
     * 更新学生成绩
     *
     * @param courseSelection 选课信息（包含课程ID、学生ID、教师ID和成绩）
     * @return 是否更新成功
     */
    @Override
    public boolean updateScore(CourseSelection courseSelection) {
        return courseSelectionMapper.update(courseSelection,
                new LambdaQueryWrapper<CourseSelection>()
                        .eq(CourseSelection::getCourseId, courseSelection.getCourseId())
                        .eq(CourseSelection::getStudentId, courseSelection.getStudentId())
                        .eq(CourseSelection::getTeacherId, courseSelection.getTeacherId())) > 0;
    }


    @Override
    public List<String> getCourseTeachersByCourseId(Integer courseId) {
        return courseTeacherMapper.selectList(
                new LambdaQueryWrapper<CourseTeacher>()
                        .select(CourseTeacher::getUserId)
                        .eq(CourseTeacher::getCourseId, courseId)
        ).stream().map(CourseTeacher::getUserId).toList();
    }

    @Override
    public Page<CourseWithTeacherView> getCourseWithTeachersByTeacherId(String teacherId, long current, long size) {
        Page<CourseWithTeacherView> page = new Page<>(current, size);
        return courseWithTeacherViewMapper.selectPage(page,
                new LambdaQueryWrapper<CourseWithTeacherView>().eq(CourseWithTeacherView::getTeacherId, teacherId));
    }
}