package com.dayuan.service.DataCheck;


import com.dayuan.bean.dataCheck.DataCheckRecordingAddendum;
import com.dayuan.mapper.dataCheck.DataCheckRecordingAddendumMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 *
 */
@Service
public class DataCheckRecordingAddendumService extends BaseService<DataCheckRecordingAddendum, Integer> {
	@Autowired
	private DataCheckRecordingAddendumMapper mapper;
	
	public DataCheckRecordingAddendumMapper getMapper() {
		return mapper;
	}

	public int updateByRid (DataCheckRecordingAddendum addendum){
		return mapper.updateByRid(addendum);
	}

}
