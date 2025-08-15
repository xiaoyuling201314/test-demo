package com.dayuan.service.data;

import com.dayuan.bean.data.TbFile;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.data.TbFileMapper;
import com.dayuan.service.BaseService;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.UUIDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
public class TbFileService extends BaseService<TbFile, Integer> {
    @Autowired
    private TbFileMapper mapper;

    @Override
    public BaseMapper<TbFile, Integer> getMapper() {
        return mapper;
    }

    public List<TbFile> queryBySource(Integer sourceId, String sourceType) {
        return mapper.queryBySource(sourceId, sourceType);
    }


    /**
     * 文件保存和文件信息插入
     *
     * @param files 文件数组对象
     * @param sId   文件对应源ID
     * @param type  文件对应类型
     * @return 返回当前保存的文件生成的ID
     * @throws Exception
     * @Author shit
     */
    public List<Integer> saveFile(MultipartFile[] files, Integer sId, String type, String fPath) throws Exception {
        List<Integer> fileIds = new ArrayList<>();
        if (files.length > 0 && !files[0].isEmpty()) {
            for (MultipartFile file : files) {
                setParamtFile(file, fPath, sId, type, fileIds);
            }
        }
        return fileIds;
    }

    /**
     * 设置基础参数并保存文件
     *
     * @param file
     * @param fPath
     * @param sId
     * @param type
     * @param fileIds
     * @throws Exception
     */
    private void setParamtFile(MultipartFile file, String fPath, Integer sId, String type, List<Integer> fileIds) throws Exception {
        String originalName = file.getOriginalFilename();
        String fName = UUIDGenerator.generate() + DyFileUtil.getFileExtension(originalName);    //文件名
        String fileName = DyFileUtil.uploadFile(fPath, file, fName);    //保存附件
        TbFile tbFile = new TbFile();
        tbFile.setFileName(originalName);
        tbFile.setFilePath(fPath + fileName);
        tbFile.setSourceId(sId);
        tbFile.setSourceType(type);
        PublicUtil.setCommonForTable(tbFile, true);//设置基础参数
        this.insert(tbFile);
        String id = tbFile.getId();
        fileIds.add(Integer.valueOf(id));//把当前文件的ID添加进入集合返回
    }

    /**
     * 根据路径查询文件真实名称
     * @param path
     * @return
     */
    public String selectNameByPath(String path) {
        return mapper.selectNameByPath(path);
    }
}